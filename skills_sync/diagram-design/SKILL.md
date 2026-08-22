---
name: diagram-design
description: Agent-native professional diagram & visual architecture generator. Creates clean, non-overlapping Mermaid, SVG, and structured architecture charts, sequence flows, state machines, timelines, and quadrant matrices for documentation and planning.
---

# 🎨 Diagram Design (Agent-Native Architecture & Chart Generator)

This skill provides verified, beautifully formatted, non-overlapping diagram patterns (Mermaid & ASCII/SVG) for AI agents to embed into documentation, system proposals, and user walkthroughs.

## 🚀 When to Use
- Whenever designing or explaining a system architecture, software flow, API lifecycle, or state machine.
- When generating reports, implementation plans, or Obsidian notes requiring clean visual diagrams.
- Eliminates common LLM diagram failures (overlapping arrows, broken brackets, invalid syntax).

## 🛠️ Execution & Templates

실존 경로:
```powershell
python "C:\Users\ildoc\.gemini\config\skills\diagram-design\scripts\diagram_engine.py" <chart_type>
```

지원 차트 유형 (`<chart_type>`):
1. `architecture`: 3-Tier / Gateway / Agent / Storage 아키텍처 다이어그램
2. `flowchart`: 의사결정 및 자율 에러 복구 루프 흐름도
3. `state_machine`: 시스템 상태 전이 다이어그램 (State Diagram)
4. `timeline`: 마일스톤 및 릴리즈 로드맵 (Gantt)
5. `quadrant`: 가치 vs 난이도 2x2 우선순위 매트릭스 (Quadrant Chart)

## 📋 핵심 작성 원칙
1. **특수문자 이스케이프**: 노드 텍스트에 괄호, 쉼표, 콜론이 포함될 때는 반드시 큰따옴표(`id["Label (Info)"]`)로 감싸 파싱 에러를 방지한다.
2. **명확한 계층 분리**: `subgraph`를 활용해 클라이언트, 게이트웨이, 백엔드 코어, 스토리지 레이어를 논리적으로 명확히 분리한다.
3. **가독성 높은 팔레트(classDef)**: 눈이 피로하지 않은 차분한 HSL/파스텔톤 테마 스타일 클래스를 기본 적용한다.
