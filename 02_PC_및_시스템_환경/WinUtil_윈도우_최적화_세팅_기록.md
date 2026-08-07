---
title: 🛠️ WinUtil 윈도우 최적화 세팅 및 실행 기록 (2026-08-06)
tags:
  - windows
  - optimization
  - winutil
  - christitustech
  - system-setup
date: 2026-08-06
---

# 🛠️ WinUtil 윈도우 최적화 세팅 및 실행 기록

> **최종 실행일**: 2026-08-06
> **도구**: Chris Titus Tech Windows Utility (WinUtil v26.08.04)
> **실행 권한**: 관리자 권한 (Administrator)

---

## 📌 1. 적용된 트윅 (Essential Tweaks / Standard Recommended)

| 최적화 항목 (Tweak Name) | 설명 및 변경 사항 | 상태 |
| :--- | :--- | :---: |
| **`ConsumerFeatures - Disable`** | 윈도우 자동 추천 앱/게임(캔디크러쉬 등) 무단 강제 설치 방지 (`DisableWindowsConsumerFeatures = 1`) | ✅ 적용 완료 |
| **`ExplorerAutoDiscovery - Disable`** | 탐색기 자동 폴더 유형 탐색으로 인한 렉 방지 (`AllFolders\Shell` 설정) | ✅ 적용 완료 |
| **`WPBT - Disable`** | 바이오스(WPBT) 기반 제조사 프로그램 강제 설치/실행 차단 (`DisableWpbtExecution = 1`) | ✅ 적용 완료 |
| **`Location Tracking - Disable`** | 위치 추적 서비스(`lfsvc`) 비활성화 및 접근 권한 거부(`Deny`) | ✅ 적용 완료 |
| **`Services - Set to Manual/Disable`** | 불필요 백그라운드 서비스 정리 (`DiagTrack` 진단트래킹, `CscService` 차단 / `MapsBroker` 수동 전환) | ✅ 적용 완료 |
| **`Telemetry - Disable`** | 마이크로소프트 광고 ID, 사생활 모니터링, 음성/입력 진단 수집 전면 비활성화 (`AllowTelemetry = 0`) | ✅ 적용 완료 |
| **`Delivery Optimization - Disable`** | 윈도우 업데이트 P2P 분산 공유 비활성화 (`DODownloadMode = 0`) -> 네트워크 핑 개선 | ✅ 적용 완료 |
| **`Delete Temp Files`** | 윈도우 임시 파일 및 찌꺼기 파일 전면 삭제 | ✅ 적용 완료 |
| **`End Task on Taskbar`** | 작업 표시줄 앱 아이콘 우클릭 시 '작업 종료(End Task)' 메뉴 추가 (`TaskbarEndTask = 1`) | ✅ 적용 완료 |

---

## 🛠️ 2. 실행 명령어 및 복구 방법

### 🚀 WinUtil 실행 명령어 (PowerShell 관리자 권한)
```powershell
irm "https://christitus.com/win" | iex
```

### 🔄 원복(Restore/Undo) 방법
* WinUtil 실행 후 `Tweaks` 탭에서 동일 항목 선택 ➔ **`Undo Selected Tweaks`** 버튼 클릭.
* 복원 지점(System Restore Point) 사용 시 이전 상태로 복구 가능.

---

## 🔗 관련 문서
- [[PC_시스템_및_하드웨어_종합_가이드]]
- [[GEMINI.md]]
- [[📚 인덱스]]
