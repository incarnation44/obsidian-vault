import sys
import argparse
import re

sys.stdout.reconfigure(encoding='utf-8')

TEMPLATES = {
    "architecture": """```mermaid
flowchart TB
    subgraph Client["🖥️ Client Layer (Frontend)"]
        UI["Vite + React UI"]
        State["Zustand / Reactive Store"]
        UI <--> State
    end

    subgraph Gateway["🛡️ Gateway & Auth Layer"]
        Nginx["Reverse Proxy / Nginx"]
        Auth["OAuth2 / JWT Token Auth"]
        Nginx --> Auth
    end

    subgraph Services["⚙️ Backend & Agent Core (FastAPI)"]
        API["REST API Router"]
        Orchestrator["Agent Orchestrator"]
        LLM["Model Router (Cloud / Local Ollama)"]
        API --> Orchestrator
        Orchestrator --> LLM
    end

    subgraph Storage["💾 Persistence Layer"]
        DB[("PostgreSQL / Cloud SQL")]
        MemoryDB[("Agent SQLite Memory (memory.db)")]
        Vault[("Obsidian Knowledge Vault")]
    end

    Client <--> Gateway
    Gateway <--> Services
    Services <--> DB
    Services <--> MemoryDB
    Services <--> Vault

    classDef clientStyle fill:#EBF8FF,stroke:#3182CE,stroke-width:2px,color:#2B6CB0;
    classDef gwStyle fill:#FEFCBF,stroke:#D69E2E,stroke-width:2px,color:#744210;
    classDef svcStyle fill:#E6FFFA,stroke:#319795,stroke-width:2px,color:#234E52;
    classDef dbStyle fill:#EDF2F7,stroke:#4A5568,stroke-width:2px,color:#1A202C;

    class UI,State clientStyle;
    class Nginx,Auth gwStyle;
    class API,Orchestrator,LLM svcStyle;
    class DB,MemoryDB,Vault dbStyle;
```""",

    "flowchart": """```mermaid
flowchart TD
    Start(["🚀 작업 시작 / 사용자 요청"]) --> Router{"🎯 요청 유형 분석"}
    
    Router -->|"단순 질의 / 리서치"| FastPath["⚡ 즉시 응답 / 스킬 실행"]
    Router -->|"복잡한 개발 / 아키텍처"| PlanPhase["📋 Implementation Plan 수립"]
    
    PlanPhase --> ExecPhase["🛠️ 자율 실행 및 코드 작성"]
    ExecPhase --> EvalPhase{"🔍 실행 검증 (Build & Eval)"}
    
    EvalPhase -->|"오류 발생"| AutoFix["🔧 원인 분석 및 자동 복구"]
    AutoFix --> ExecPhase
    
    EvalPhase -->|"성공"| VaultArchive["📝 옵시디언 볼트 기록 및 인덱싱"]
    FastPath --> VaultArchive
    
    VaultArchive --> End(["✅ 최종 완료 및 결과 보고"])

    classDef startEnd fill:#EBF8FF,stroke:#3182CE,stroke-width:2px,color:#2B6CB0;
    classDef process fill:#F7FAFC,stroke:#4A5568,stroke-width:1.5px,color:#2D3748;
    classDef decision fill:#FEFCBF,stroke:#D69E2E,stroke-width:2px,color:#744210;
    classDef success fill:#C6F6D5,stroke:#38A169,stroke-width:2px,color:#22543D;

    class Start,End startEnd;
    class FastPath,PlanPhase,ExecPhase,AutoFix,VaultArchive process;
    class Router,EvalPhase decision;
```""",

    "state_machine": """```mermaid
stateDiagram-v2
    [*] --> IDLE : 시스템 대기
    IDLE --> RECEIVING : 사용자 요청 수신
    RECEIVING --> ROUTING : 의도 및 도구 분석
    
    ROUTING --> PLANNING : 복잡한 태스크
    ROUTING --> EXECUTING : 단일 액션
    
    PLANNING --> EXECUTING : 플랜 확정
    
    state EXECUTING {
        [*] --> TOOL_CALL
        TOOL_CALL --> VERIFYING : 도구 실행 완료
        VERIFYING --> TOOL_CALL : 추가 도구 필요
        VERIFYING --> SUCCESS : 검증 완료
        VERIFYING --> ERROR_RECOVERY : 에러 감지
        ERROR_RECOVERY --> TOOL_CALL : 자율 수정
    }
    
    EXECUTING --> ARCHIVING : 결과 산출
    ARCHIVING --> IDLE : 볼트 저장 및 완료 보고
```""",

    "timeline": """```mermaid
gantt
    title 🚀 프로젝트 마일스톤 및 릴리즈 로드맵
    dateFormat  YYYY-MM-DD
    section 1단계: 분석 및 기반 설계
    요구사항 정의 & 아키텍처 수립 :done, des1, 2026-08-18, 2d
    데이터베이스 스키마 & RLS 설계 :done, des2, after des1, 2d
    section 2단계: 코어 개발
    REST API 및 에이전트 하네스 구현 :active, dev1, after des2, 4d
    Vite 프론트엔드 UI/UX 구현 :dev2, after dev1, 4d
    section 3단계: 검증 및 배포
    E2E 통합 테스트 & 보안 점검 :test1, after dev2, 2d
    Cloud Run / Vercel 원클릭 배포 :dep1, after test1, 1d
```""",

    "quadrant": """```mermaid
quadrantChart
    title 🎯 기술 및 기능 우선순위 매트릭스 (가치 vs 난이도)
    x-axis 낮은 난이도 (빠른 구현) --> 높은 난이도 (복잡한 구현)
    y-axis 낮은 비즈니스 가치 --> 높은 비즈니스 가치
    quadrant-1 🌟 전략적 핵심 과제 (Big Bets)
    quadrant-2 🚀 즉시 실행 과제 (Quick Wins)
    quadrant-3 💤 보류 과제 (Low Priority)
    quadrant-4 ⏳ 장기 연구 과제 (Tech Debt)
    
    "Obsidian Skills 연동": [0.25, 0.85]
    "Diagram Design 스킬": [0.20, 0.80]
    "Ollama 로컬 모델 파인튜닝": [0.75, 0.88]
    "Buzz Nostr 협업 인프라": [0.85, 0.65]
    "정적 웹사이트 배포": [0.15, 0.40]
    "복잡한 레거시 마이그레이션": [0.80, 0.25]
```"""
}

def validate_mermaid(mermaid_code: str) -> bool:
    """Basic sanity check for Mermaid syntax to prevent rendering errors."""
    code = mermaid_code.strip()
    if not (code.startswith("```mermaid") and code.endswith("```")):
        # Ensure code is wrapped in mermaid block
        return False
    # Check for unmatched brackets
    content = code[len("```mermaid"):-len("```")].strip()
    open_brackets = content.count("[") + content.count("(") + content.count("{")
    close_brackets = content.count("]") + content.count(")") + content.count("}")
    return open_brackets == close_brackets

def get_diagram(chart_type: str) -> str:
    chart_type = chart_type.lower().strip()
    if chart_type in TEMPLATES:
        return TEMPLATES[chart_type]
    available = ", ".join(TEMPLATES.keys())
    return f"Unknown chart type '{chart_type}'. Available: {available}"

def main():
    parser = argparse.ArgumentParser(description="Diagram Design Engine for AI Agents")
    parser.add_argument("type", nargs="?", default="architecture", choices=["architecture", "flowchart", "state_machine", "timeline", "quadrant", "list"])
    args = parser.parse_args()

    if args.type == "list":
        print("Available Diagram Types:")
        for k in TEMPLATES.keys():
            print(f" - {k}")
        return

    diagram = get_diagram(args.type)
    print(diagram)

if __name__ == "__main__":
    main()
