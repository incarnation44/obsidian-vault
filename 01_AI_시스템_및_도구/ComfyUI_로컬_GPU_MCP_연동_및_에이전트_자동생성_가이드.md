---
title: "ComfyUI 로컬 GPU MCP 연동 및 에이전트 자동생성 가이드"
created: 2026-08-23
tags:
  - comfyui
  - mcp
  - local-gpu
  - image-generation
  - automation
  - rx6600
source: "ComfyUI Official Local MCP Release / IT News 2026-08-23"
published: "2026-08-23"
archived: 2026-08-23
---

# 🎨 ComfyUI 로컬 GPU MCP 연동 및 에이전트 자동생성 가이드

> **핵심 정의**: ComfyUI 공식 로컬 MCP(Model Context Protocol)는 기존 클라우드 전용 API의 한계를 넘어, **사용자의 로컬 GPU(RX 6600 8GB)에서 구동 중인 ComfyUI 인스턴스를 AI 에이전트(Antigravity, Claude Code, Codex)가 직접 제어**하여 워크플로우 실행, 모델 다운로드, 이미지/비디오 생성을 전자동으로 수행하는 통합 인터페이스입니다.

---

## 🏗️ 1. ComfyUI 로컬 MCP 구조 및 데이터 흐름

```
┌─────────────────────────────────────────────────────────────┐
│                 Antigravity / AI Coding Agent               │
└──────────────────────────────┬──────────────────────────────┘
                               │ MCP Protocol (JSON-RPC)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                   ComfyUI Local MCP Server                  │
└──────────────────────────────┬──────────────────────────────┘
                               │ Local WebSocket / REST API
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                 ComfyUI Backend (Local GPU)                 │
│  - AMD RX 6600 8GB VRAM (DirectML / ROCm / ZLUDA 가속)      │
│  - FLUX, SDXL, MiniMax H3 워크플로우 실행                    │
│  - 산출물 자동 저장: D:\사진 및 D:\사진\배경화면             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🛠️ 2. 설정 및 연동 가이드

### 1) ComfyUI MCP 설치
ComfyUI 로컬 환경 또는 에이전트 터미널에서 다음 명령어로 설치 및 등록합니다:
```bash
# ComfyUI MCP 서버 설치
npm install -g @comfyorg/comfy-mcp
# 또는 uvx / pip를 통한 Python 네이티브 구동
uvx comfy-mcp
```

### 2) MCP 설정 파일 (`mcp_config.json`) 등록 예시
`C:\Users\ildoc\.gemini\config\mcp_config.json`에 다음 설정을 추가하여 로컬 GPU 인스턴스를 바인딩합니다:
```json
{
  "mcpServers": {
    "comfyui-local": {
      "command": "uvx",
      "args": ["comfy-mcp", "--host", "127.0.0.1", "--port", "8188"],
      "env": {
        "OUTPUT_DIR": "D:\\사진\\배경화면"
      }
    }
  }
}
```

---

## 🛡️ 3. 시스템 운영 3대 필수 원칙 연계

1. **드라이브 분기 저장 원칙 (D: 드라이브 강제)**:
   - ComfyUI로 생성되는 모든 고해상도 렌더링 이미지와 영상 에셋은 메인 C: SSD의 용량 보호를 위해 반드시 **보조 SSD인 `D:\사진` 또는 `D:\사진\배경화면`**에 직접 출력되도록 경로를 고정합니다.
2. **백그라운드 비차단 연산**:
   - 대규모 렌더링 작업 시 에이전트 터미널이 블로킹되지 않도록 비동기 큐(Queue) 방식으로 태스크를 관리합니다.
3. **하드웨어 8GB VRAM 보호**:
   - 데스크톱 RX 6600 8GB 환경에 적합한 양자화 모델(FLUX.1-schnell Q4_0, SDXL Turbo 등)을 기본 프리셋으로 채택합니다.
