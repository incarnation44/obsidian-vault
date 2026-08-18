# 🤖 AI 시스템 일일 변동 로그

> 매일 Antigravity가 자동으로 기록하는 AI 시스템 변경·세팅·학습 내역.  
> `/업데이트` 시 자동 갱신 및 GitHub 동기화.

## 2026-08-18 (화)

### 🔧 시스템 변경사항
- **헌법(`GEMINI.md`) 10조 7항 신설**: `아키텍트 명세 기반 서브에이전트 하네스 & 컨텍스트 격리 (Architect Spec & Context Isolation)` 프로토콜 헌법 반영 (`config\rules\GEMINI.md` & `C:\전일도\GEMINI.md` 동기화)
- **헌법(`GEMINI.md`) 10조 8항 신설**: `실행 중심 파싱 및 시계열 능동 제안 (Actionable Parsing & Historical Delta Advisory)` 프로토콜 헌법 반영
- **`graph-orchestrator` 스킬 고도화**: `ARCHITECT.md` 역할 및 산출물 분담 템플릿과 4대 요소 정형 완료 보고(Structured Completion Report) 프로토콜 탑재
- **에이전트 메모리(`memory.db`) 의사결정 등록**: 단일 에이전트 순차 처리의 컨텍스트 포화 한계 극복 및 하네스 기반 서브에이전트 격리 패턴 / Next Action 추출 & 시계열 능동 제안 패턴 영구 저장

### 📝 새로 생성 및 갱신된 문서
- `01_AI_시스템_및_도구/하네스_유무에_따른_서브에이전트_컨텍스트_격리_차이.md`
- `01_AI_시스템_및_도구/관리직_야근_0시간_달성_AI_통합공정_OS_및_메일파싱_자동화_모범사례.md`
- `C:\Users\ildoc\.gemini\config\skills\graph-orchestrator\resources\ARCHITECT_TEMPLATE.md`

### 💡 학습 및 의사결정 기록
- 단일 에이전트가 백엔드/프론트엔드/테스트를 혼자 순차 실행하면 컨텍스트 윈도우가 급격히 포화되어 맥락 유실(Context Drift)이 발생함.
- `ARCHITECT.md`로 산출물 경로와 인터페이스를 사전 고정하고, 중간 디버깅 로그는 서브에이전트 내부 로컬 컨텍스트에 격리한 뒤 정형 완료 보고만 수신하여 메인 컨텍스트의 순수성을 보존.
- 단순 정보 요약에 머무르지 않고 "사용자가 지금 실행해야 할 1~3단계 Next Action"을 기본 도출하며, 과거 데이터(`memory.db`)와 현재 상태를 대조하여 결손이나 조치 사항을 선제적으로 계산·제안하는 능동형 어드바이저 체계 확립.


---

## 2026-08-16 (토)

### 🔧 시스템 변경사항
- **CPU 표기 정정**: `Ryzen 5 5600XT` (존재하지 않는 모델) → **`Ryzen 5 5600X`** 로 헌법(`GEMINI.md`) 및 메모리DB 일괄 수정
- **로컬 AI 메인 코딩 모델 교체**: `qwen2.5:7b` (범용) → **`qwen2.5-coder:7b`** (코딩 특화)로 1순위 변경
- **Ollama GPU 가속 확인**: RX 6600 8GB → Vulkan Compute 모드로 GPU 가속 정상 작동 확인

### 📊 실측 벤치마크 (RX 6600 8GB / Vulkan / Ollama 0.32.13)
| 모델 | 양자화 | 용량 | 실측 TPS | 비고 |
|:---|:---:|:---:|:---:|:---|
| `qwen2.5-coder:7b` | Q4_K_M | 4.36 GB | **44.17** | 코딩/스크립트 메인 ⭐ |
| `qwen2.5:7b` | Q4_K_M | 4.36 GB | **44.06** | 한국어/일반 대화 보조 |
| `deepseek-r1:8b` | Q4_K_M | 4.87 GB | **38.64** | 심층 논리 추론 |
| `qwen2.5-coder:7b` | Q5_K_M | 5.44 GB | **6.25** | ❌ 속도 86% 급락 → 삭제 |

### 🗄️ 개발 환경 세팅 (신규)
- **Oracle Database 21c XE 리스너 수리**: 유동 공인 IP → `localhost:1521` 고정 등록
- **오라클 전체 계정 비밀번호 통일**: `system/sys/hr/c##scott` → **`1234`**
- **이클립스 JDBC 연동 완료**: `ojdbc11.jar` Build Path 등록 → Java ↔ Oracle 연결 성공
- **Oracle SQL Developer 24.3.1 설치**: 바탕화면 공식 바로가기 생성

### 📝 새로 생성된 문서
- `04_개발_및_히스토리/2026-08-16_Java21_Eclipse_Oracle21c_환경설정_완전기록.md`

### 💡 학습 및 의사결정 기록
- Q5_K_M이 이론상 VRAM(8GB)에 들어가야 하지만 실측에서 6.25 TPS로 급락 → 원인은 GPU/CPU offload 또는 Vulkan 런타임 제약으로 추정 (확정 불가)
- 모델 파일 크기 ≠ 실행 시 GPU 메모리 사용량 (가중치 + KV캐시 + 컴퓨트 버퍼 합산 필요)
- "현재 측정한 모델 후보 중 최적"이라는 표현이 "100% 완벽 최적화"보다 정확함

### 🔮 대기 중인 작업
- 화요일 DELL Latitude 7440 직거래 (550,000원) — 현장 3단계 체크리스트 준비 완료
