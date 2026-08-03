---
title: 💻 PC 시스템 세팅 및 오류 해결 노하우
tags:
  - pc-setup
  - windows
  - troubleshooting
  - optimization
date: 2026-08-03
---

# 💻 PC 시스템 세팅 및 오류 해결 노하우

이 문서는 대화 및 작업 히스토리를 바탕으로 **윈도우 PC 시스템 최적화, 시작 프로그램 관리, 각종 시스템 오류 해결법**을 정리한 가이드 문서입니다.

---

## 1. 🚀 시작 프로그램 설정 및 부팅 최적화

### 📌 부팅 속도 저하 방지 관리법
- **AMDAutoUpdate 팝업/검은 창 조치**:
  - `C:\Program Files\AMD\AutoUpdate\AMDAutoUpdate.exe` 백그라운드 주기 실행 문제.
  - 해결: 작업 관리자 [시작 앱] 탭 비활성화 및 [작업 스케줄러]의 AMD 자동 업데이트 트리거 비활성화.
- **체크 경로**:
  - `작업 관리자(Ctrl+Shift+Esc)` ➔ [시작 앱]
  - 레지스트리: `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`

---

## 2. 🛠️ 시스템 오류 해결 조치 모음

### 🖥️ 모니터 & 계정 로그인 오류 해결
- **증상**: 윈도우 부팅 후 모니터 화면 미출력 또는 계정 로그인 실패/무한 로딩.
- **해결 절차**:
  1. 안전 모드(Safe Mode) 진입 후 그래픽 드라이버(DDU) 재설치.
  2. `sysdm.cpl` ➔ 원격/디스플레이 설정 및 Fast Startup(빠른 시작) 기능 비활성화.

### 🔄 윈도우 & 프로그램 업데이트 오류 해결
- **증상**: 업데이트 다운로드 중 멈춤 또는 오류 코드 발생.
- **해결 절차**:
  1. `Windows Update` 서비스 중지 (`net stop wuauserv`).
  2. `C:\Windows\SoftwareDistribution` 폴더 내부 임시 파일 삭제 후 서비스 재시작(`net start wuauserv`).

### 📱 휴대폰 스크린샷 자동 연동 해제
- **증상**: 스마트폰으로 캡처한 스크린샷이 PC로 자동 동기화되어 저장 공간을 차지함.
- **해결**: [Windows 휴대폰과 연결] ➔ 설정 ➔ 사진/스크린샷 동기화 옵션 비활성화.

---

## 3. 🖥️ 하드웨어 사양 정보

- **CPU**: AMD Ryzen 5 5600XT (6 Cores / 12 Threads)
- **GPU**: AMD Radeon RX 6600 (8GB VRAM)
- **RAM**: 32 GB (DDR4 3200 MHz)
- **PSU (파워)**: AONE 시그니처 750W 80PLUS BRONZE 풀모듈러 (ATX 3.1)
- **OS**: Windows 11 Pro (64-bit)

---

## 🔗 관련 문서
- [[🛠️ 설치된 도구 목록]]
- [[📋 터미널 작업 히스토리]]
- [[📚 인덱스]]
