---
title: God's Eye View — Real-time Earth Digital Twin
created: 2026-09-12
updated: 2026-09-12
type: concept
tags: [geospatial, real-time, open-source, 3d-globe, voice-control, ads-b, ais]
sources: [raw/transcripts/gods-eye-view-walkthrough.md]
confidence: high
---

# God's Eye View

실시간 지구 관측 오픈소스 웹 앱. CesiumJS + Google 3D Tiles 기반.

## 핵심 가치
- **단일 창(Collective Window)**: 항공, 해상, 재난, 인프라, 감시 데이터를 하나의 글로브에 통합.
- **접근성**: Pinokio 원클릭 설치로 비개발자도 즉시 실행.
- **확장성**: AI 코딩 에이전트에게 자연어로 기능 추가 지시 가능.
- **데이터 주권**: API 키 로컬 저장, 서버 전송 없음.

## 주요 레이어 (Data Layers)

| 레이어 | 데이터 소스 | 설명 |
|--------|-------------|------|
| **Flights (ADS-B)** | ADS-B Exchange, OpenSky | 민간(흰색)/군용(노랑) 실시간 항공기. 조종석 1인칭 뷰 지원. |
| **Ships (AIS)** | AISHub, MarineTraffic | 실시간 선박 위치, 항로, 선박 정보. |
| **Fires** | NASA FIRMS | 위성 기반 화재 핫스팟 근실시간. |
| **Earthquakes** | USGS | 실시간 지진 발생 위치/규모. |
| **Subsea Cables** | Submarine Cable Map | 해저 광케이블, 랜딩 포인트, 데이터센터. |
| **Traffic Cameras** | 공공 CCTV 피드 | 전 세계 교통/공공 카메라 실시간 스트림. |
| **Celestial Mode** | 계산 기반 | 태양/달 위치, 그림자 실시간 표시. |

## 기술 스택 & 키 요구사항

| 구성요소 | 용도 | 키 필요 여부 |
|----------|------|-------------|
| **CesiumJS** | 3D 글로브 렌더링 | - |
| **Google 3D Tiles** | 포토리얼 3D 지형/건물 | **Cesium Ion Token** (무료 커뮤니티 계정) |
| **Google Maps** | 2D 라벨, 하이브리드 맵 | Google Maps API Key (선택, 신용카드) |
| **OpenAI Realtime / TTS / Whisper** | 음성 제어 | **OpenAI API Key** (음성 필수) |
| **Mapbox** | 대체 맵 스타일 | Mapbox Token (선택) |

## 설치 및 실행

### 비개발자 (Pinokio)
1. Pinokio 8.2+ 설치: https://desktop.pinokio.co/
2. God's Eye View 앱 페이지에서 'Install' 클릭: https://pinokio.co/apps/github-com-bilawalsidhu-gods-eye-view
3. 실행 후 브라우저 자동 오픈.

### 개발자 (AI 에이전트 위임)
```bash
# 프롬프트 예시 (영상 설명란 참조)
"Set up God's Eye View from https://github.com/bilawalsidhu/gods-eye-view on my computer. 
Read the current README, check prerequisites, install, launch keyless version. 
Then walk me through enabling photorealistic 3D and voice in the POWER UP panel. 
Guide me through any new API keys I need, but keep API keys local."
```

## 음성 제어 (Voice Control) 활성화
1. 앱 우하단 **Power Up** → **Manage** 클릭
2. **OpenAI API Key** 입력 → Save Keys
3. 글로브 우측 마이크 아이콘 클릭 → 자연어 명령:
   - "Show me all flights over Europe"
   - "Take me to the cockpit of that plane"
   - "Show fires in California"
   - "Switch to satellite view"

## 확장 포인트 (Building on Top)
- **실험적 레이어**: ALPR(자동 번호판 인식), SDR(소프트웨어 정의 라디오) 연동 등 `main` 브랜치 외 브랜치/PR에 존재.
- **자연어 기능 추가**: AI 에이전트에 "이 API 연동해줘", "이런 레이어 추가해줘" 지시.
- **기여**: PR 환영, CONTRIBUTING.md 참고.

## 관련 문서
- [[llm-wiki-architecture]]
- [[ai-coding-skills-landscape]]
