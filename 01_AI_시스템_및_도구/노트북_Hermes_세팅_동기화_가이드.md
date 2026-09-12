# 노트북 Hermes 세팅 동기화 가이드 (본체 ↔ 노트북)

> 본체(`desktop`, Ryzen 5600XT)에서 검증된 Hermes `berber44` 프로필을 노트북에 **동일하게 복제**하는 체크리스트입니다.
> GitHub(obsidian-vault, KH_AI)와 옵시디언 볼트(`C:\전일도`)가 동기화 전제입니다.

---

## 0. 사전 준비 (노트북에서 1회)

```bash
# 1) Git 설치 확인
git --version

# 2) GitHub 인증 (SSH 키 또는 PAT)
# SSH 권장: ssh-keygen -t ed25519 -C "email" → GitHub Settings > SSH keys 등록

# 3) Anaconda/Miniconda 설치 (pytest, npenv 환경용)
# https://docs.anaconda.com/minicadonde/miniconda-install/

# 4) Hermes Desktop 앱 설치
# https://hermes-agent.nousresearch.com/download
```

---

## 1. 옵시디언 볼트 클론 및 동기화

```bash
# 볼트 루트 (본체와 동일 경로 권장)
cd /c/전일도   # Git Bash 기준
# 또는
cd C:\전일도   # PowerShell 기준

# 이미 폴더가 있다면 pull만
git pull origin master

# 처음이면 클론
git clone git@github.com:incarnation44/obsidian-vault.git 전일도
cd 전일도
```

**확인**: `03_운영/ADR/Hermes_Agent_권한_설계_3원칙_ADR.md` 파일이 최신 커밋(`a3ab5b8`)에 있는지 확인

---

## 2. KH_AI 저장소 클론 (수업 자료용)

```bash
cd /c/KH_AI
git clone git@github.com:incarnation44/KH_AI.git .
git pull origin main
```

**확인**: `PROJECT_STATUS.md`에 `Phase 2-1 PASS`, `decisions.md`에 본체 사양(`Ryzen 5600XT`, `Gigabyte A520M K V2`) 반영됐는지 확인

---

## 3. Hermes 프로필 `berber44` 생성 및 설정 복사

### 3-1. Hermes 앱에서 프로필 생성
1. Hermes Desktop 실행 → 우상단 프로필 메뉴 → **New Profile**
2. 이름: `berber44` (본체와 동일)
3. 프로필 폴더 자동 생성: `C:\Users\<사용자명>\AppData\Local\hermes\profiles\berber44\`

### 3-2. 설정 파일 복사 (본체 → 노트북)

**방법 A: 파일 직접 복사 (USB/네트워크/클라우드)**
본체에서 다음 파일들을 노트북 동일 경로로 복사:
```
C:\Users\ildoc\AppData\Local\hermes\profiles\berber44\
├── config.yaml          # 모델 설정 (OpenRouter 등)
├── SOUL.md              # 시스템 프롬프트
├── .env                 # OPENROUTER_API_KEY 등 비밀키
├── auth.json            # 인증 토큰 (hermes auth 로그인 후 생성)
├── memories/
│   ├── MEMORY.md        # 영구 메모리 (36개 규칙)
│   └── USER.md          # 사용자 프로필
└── skills/
    ├── i-have-adhd/     # 볼트에서 복사된 스킬
    ├── planning-with-files/
    └── vault-setup-sync/
```

**방법 B: Git으로 동기화 (권장)**
본체에서 프로필 설정을 별도 레포로 관리 중이라면 클론. 없다면 방법 A 사용.

> ⚠️ **비밀키(.env, auth.json)는 Git에 올리지 말고 직접 복사하세요.**

### 3-3. 스킬 3종 볼트에서 복사 (이미 되어 있다면 생략)
```bash
# 볼트 내 스킬 소스
C:\전일도\03_운영\hermes-setup-berber44\skills\
  ├── i-have-adhd\
  ├── planning-with-files\
  └── vault-setup-sync\

# 대상: Hermes 프로필 스킬 폴더
C:\Users\<사용자명>\AppData\Local\hermes\profiles\berber44\skills\
```
폴더째 복사 후 Hermes 재시작.

---

## 4. 모델·API 키 설정 (OpenRouter 3티어)

### 4-1. OpenRouter API 키 발급·충전
1. https://openrouter.ai/keys → Create Key
2. $5 충전 (권장: GLM 5.3 Flash 메인용)
3. 키 복사

### 4-2. Hermes에 키 등록
**옵션 1: `.env` 파일에 저장 (권장)**
```bash
# 프로필 폴더에 .env 생성
echo "OPENROUTER_API_KEY=sk-or-xxxxxxxxxxxx" > "C:\Users\<사용자>\AppData\Local\hermes\profiles\berber44\.env"
```

**옵션 2: Hermes UI에서 등록**
- Settings → Providers → OpenRouter → API Key 입력 → Save

### 4-3. 3티어 모델 전략 (config.yaml 반영)
| 티어 | 모델 ID | 용도 | 단가(입력/출력 per 1M) |
|------|---------|------|------------------------|
| 1순위 | `z-ai/glm-5.3-flash` | 평상시 조사·요약·코딩 | $0.075 / $0.25 |
| 2순위 | `google/gemini-3.8-flash` | 한글·스크린샷·긴 컨텍스트 | $0.75 / $3.75 |
| 3순위 | `anthropic/claude-sonnet-4` | 고난도 추론·설계 | $2.00 / $10.00 |

> 현재 `config.yaml`은 `muse-spark-1.3-contributor-free`(무료) 기본값. 필요시 `/model` 명령이나 UI에서 전환.

---

## 5. 유튜브 자막 스크립트 연동 (Antigravity 공유)

본체에서 검증된 `instant_transcript.py`를 노트북에도 동일 경로 배치:

```bash
# 대상 경로 생성
mkdir -p "C:\Users\<사용자>\.gemini\config\skills\youtube-transcribe\scripts"
mkdir -p "C:\Users\<사용자>\.gemini\antigravity\scratch"

# 본체에서 복사할 파일
# C:\Users\ildoc\.gemini\config\skills\youtube-transcribe\scripts\instant_transcript.py
# → 노트북 동일 경로

# 테스트
echo "https://youtu.be/sKI2x3WvBLA" > "C:\Users\<사용자>\.gemini\antigravity\scratch\target_yt.txt"
python "C:\Users\<사용자>\.gemini\config\skills\youtube-transcribe\scripts\instant_transcript.py"
```

---

## 6. WSL + 개발 환경 (본체와 동일)

```bash
# 1) WSL Ubuntu 24.04 설치 (이미 있으면 생략)
wsl --install -d Ubuntu-24.04
wsl -d Ubuntu-24.04 -u root apt update && apt install -y fonts-nanum
wsl -d Ubuntu-24.04 -u root rm -rf /root/.cache/matplotlib

# 2) Anaconda 환경 생성 (본체와 동일)
conda create -n pytest python=3.11.16 -y
conda activate pytest
conda install -y numpy=2.4.6 pandas=3.0.5 pytest=9.1.1 matplotlib seaborn openpyxl jupyter
pip install torch==2.14.0 --index-url https://download.pytorch.org/whl/cpu
pip install opencv-python==5.0.0.93

conda create -n npenv python=3.10.21 -y
conda activate npenv
conda install -y numpy pandas matplotlib seaborn openpyxl jupyter

# 3) 검증
conda activate pytest
cd /c/KH_AI
python test.py  # ALL PASS 확인
```

---

## 7. Git·옵시디언 동기화 규칙 (헌법 준수)

**매일/작업 종료 시 노트북에서 실행:**
```bash
# 1) 옵시디언 볼트
cd /c/전일도
git pull origin master          # ★ 반드시 pull 먼저
git add .
git commit -m "[LAPTOP][Hermes] <작업 요약>"
git push origin master          # 명시적 요청 시만 push

# 2) KH_AI
cd /c/KH_AI
git pull origin main
git add .
git commit -m "[LAPTOP][Hermes] <작업 요약>"
git push origin main
```

**커밋 태그 규칙**: `[LAPTOP][Hermes]` 또는 `[DESKTOP][Hermes]` 필수

---

## 8. 검증 체크리스트 (노트북에서 모두 ✅ 확인 후 완료)

| 항목 | 확인 방법 | 기대 결과 |
|------|-----------|-----------|
| 옵시디언 볼트 최신화 | `git log -1 --oneline` | `a3ab5b8` (ADR 커밋) |
| KH_AI 최신화 | `git log -1 --oneline` | `bd825b7` (실습환경 완료) |
| Hermes 프로필 로드 | 앱 재시작 → 프로필 `berber44` 선택 | 설정·메모리·스킬 모두 로드 |
| OpenRouter 키 작동 | 채팅에서 `/model openrouter/z-ai/glm-5.3-flash` 후 질문 | 응답 정상 |
| 유튜브 자막 추출 | 위 5번 테스트 명령 실행 | 자막 텍스트 출력 |
| WSL Ubuntu 24.04 | `wsl -d Ubuntu-24.04 lsb_release -a` | `noble` 24.04.4 LTS |
| pytest 환경 | `conda activate pytest && python test.py` | ALL PASS |
| npenv 환경 | `conda activate npenv && jupyter --version` | 버전 출력 |
| 메모리 규칙 적용 | 채팅에서 한국어·태그·헌법 준수 여부 | 정상 동작 |

---

## 9. 트러블슈팅 빠른 참조

| 증상 | 원인 | 해결 |
|------|------|------|
| Hermes 프로필 안 보임 | 폴더명 불일치 | `berber44` 폴더명 정확히 맞춤 |
| OpenRouter 401/429 | 키 만료·한도 초과 | 키 재발급·충전·모델 변경 |
| 유튜브 자막 실패 | 스크립트 경로 틀림 | `instant_transcript.py` 절대경로 확인 |
| Git push 거부 | 로컬 뒤처짐 | `git pull --rebase` 후 재시도 |
| WSL 한글 깨짐 | 폰트 미설치 | `sudo apt install fonts-nanum && rm -rf ~/.cache/matplotlib` |
| conda env 안 보임 | 셸 재시작 필요 | 터미널 재시작 또는 `conda init` |

---

## 10. 본체↔노트북 차이점만 관리 (동기화 제외 대상)

| 항목 | 본체 (desktop) | 노트북 (laptop) | 비고 |
|------|----------------|-----------------|------|
| 하드웨어 | Ryzen 5600XT, RX 6600 8GB, 32GB RAM | **Dell 노트북 실사양 확인 후 기록** | `decisions.md`에 각 기기 사양 별도 기록 |
| WSL 사용 | WSL2 Ubuntu 24.04 기본 | 동일 구성 (커널 버전만 다를 수 있음) | `wsl -l -v`로 확인 |
| GPU 가속 | RX 6600 (ROCm/CPU 폴백) | **노트북 GPU 확인 후 설정** (내장/외장) | 로컬 LLM 돌릴 때만 관련, 없으면 CPU 모드 |
| Antigravity | 미설치 (본체 전용) | 설치됨 (메인 IDE) | Hermes와 영역 분리 유지 |
| Hermes 프로필 경로 | `C:\Users\ildoc\...` | `C:\Users\<노트북계정>\...` | 사용자명 다를 수 있음, 경로 수정 필수 |
| Anaconda 경로 | 본체 설치 경로 | 노트북 설치 경로 | `conda info --base`로 확인 |
| .env / auth.json | 본체 발급 키 | **노트북에서 별도 발급/복사** | Git에 올리지 말고 직접 전달 |

---

## 📌 한 줄 요약

> **Git pull → 설정 파일 복사(.env/auth.json 수동) → 스킬 3종 복사 → OpenRouter 키 등록 → WSL/conda 환경 동일 구축 → 검증 체크리스트 통과 → 이후 매일 pull-first 동기화**

이 문서를 `C:\전일도\01_AI_시스템_및_도구\노트북_Hermes_세팅_동기화_가이드.md`로 저장해 두고, 노트북에서 순서대로 실행하세요. [Hermes|desktop]