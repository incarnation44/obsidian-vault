# PC 시스템 및 하드웨어 종합 가이드

> **통합 업데이트**: 2026-08-15
> 이 폴더(`02_PC_및_시스템_환경`)가 PC 노트의 본진이다. 예전 `01_PC_및_시스템_최적화` 윈도우 꿀팁 3편은 여기로 옮겼고, 옛 경로에는 리다이렉트만 남겼다. 원룸 곰팡이 가이드는 생활 폴더로 뺐다.

관련 윈도우 실무:
- [[윈도우11_숨겨진_5대_필수꿀팁_모음]]
- [[05_윈도우11_시스템_복원지점_생성_및_복구_완전정복]]
- [[윈도우11_필수_무료앱_TOP3_추천]]
- [[WinUtil_윈도우_최적화_세팅_기록]]
- [[새_노트북_언박싱부터_윈도우11_최적화까지_완벽_매뉴얼]]
- [[노트북_구매_후보_비교_및_아카이브]]

---

## 1. 이 PC 부품 명세 (로컬 전용)

WMI·디바이스 진단으로 모은 실제 부품이다.

| 구분 | 제조사 | 모델 | 규격 |
| :---: | :--- | :--- | :--- |
| 메인보드 | Gigabyte | A520M K V2 | AM4, M.2, M-ATX |
| CPU | AMD | Ryzen 5 5600XT | 6C/12T, 3.7 GHz |
| GPU | XFX (STCOM) | RX 6600 Speedster SWFT 210 | 8 GB GDDR6, DirectML |
| RAM | DDR4 | 32 GB (16×2) | 3200 MHz, FCLK 1:1 / 1600 MHz |
| C: SSD | Crucial | P3 Plus 1 TB (`CT1000P3PSSD8`) | NVMe M.2 |
| D: SSD | InnoDisk | M.2 (P42) 3TE6 | 240 GB 산업용 NVMe |
| E: SSD | ADATA | Premier Pro SP900 | 128 GB SATA |
| PSU | AONE | 시그니처 750W 80PLUS Bronze | 풀모듈러, ATX 3.1 |
| OS | Microsoft | Windows 11 Pro 64-bit | Build 10.0.26200 |

### GPU 로컬 AI 속도 (참고)
- Qwen 2.5 7B: 약 44.7 tok/s
- DeepSeek-R1 8B: 약 38.6 tok/s

### 보드·전원 메모
- A520M K V2: 라이젠 5000, M.2 NVMe, 콤팩트 M-ATX
- 750W 브론즈 풀모듈러: 이후 GPU 교체 여유

---

## 2. 세팅·오류 노하우

### 부팅이 느릴 때
- `AMDAutoUpdate.exe` 가 주기적으로 뜬다 → 작업 관리자 [시작 앱] 끄기, 작업 스케줄러의 AMD 업데이트 트리거 끄기
- 확인: `Ctrl+Shift+Esc` → [시작 앱], 레지스트리 `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`

### 모니터 깜빡 / 로그인 무한 로딩
1. 안전 모드에서 그래픽 드라이버 DDU 후 재설치
2. `sysdm.cpl` → 빠른 시작(Fast Startup) 끄기

### 윈도우 업데이트 멈춤
1. `net stop wuauserv`
2. `C:\Windows\SoftwareDistribution` 임시 파일 삭제
3. `net start wuauserv`

### 폰 캡처가 PC로 계속 들어올 때
Windows [휴대폰과 연결] → 사진/스크린샷 동기화 끄기

복원 지점·작업 끝내기·winget 일괄 업데이트는 위 윈도우 3편 노트를 본다.

---

## 3. 로컬 AI 모니터링 메모 (2026-08-05 측정, 숫자는 그날 스냅샷)

그날 기준: Ollama 정상, 성공률 100%, 평균 36.9~44.2 tok/s, P50 심층 추론 약 68초, SSD 여유 약 341 GB.

환경 변수:
- `OLLAMA_FLASH_ATTENTION=1`
- `HSA_OVERRIDE_GFX_VERSION=10.3.0` (RX 6600 / GFX1030)

라우팅 메모:
- Tier 0 로컬: qwen2.5:7b / qwen2.5-coder:7b
- Tier 1 추론: deepseek-r1:8b
- Tier 2 클라우드: Gemini / Claude / Kimi (큰 리팩터·장문)

체크포인트·DLQ 경로는 Antigravity 작업 폴더 안이다. 지식 노트에 절대경로를 더 늘리지 않는다. 실행 파일은 `Antigravity.exe`, 볼트는 `C:\전일도`.

---

## 관련 문서
- [[03_운영_및_체크리스트/세션_체크리스트_및_자동설치_가이드]]
- [[04_개발_및_히스토리/터미널_작업_히스토리]]
- [[인덱스]]
