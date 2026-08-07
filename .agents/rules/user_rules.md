# Global Antigravity System Context (전일도 사용자 공통 규칙)

## 🖥️ 1. 사용자 시스템 & 하드웨어 사양
- **메인보드**: Gigabyte A520M K V2
- **CPU**: AMD Ryzen 5 5600XT (6 Cores / 12 Threads / 3.7GHz)
- **GPU**: XFX 라데온 RX 6600 Speedster SWFT 210 Core D6 8GB (STCOM / 8GB VRAM) -> GPU 가속 활성화
- **RAM**: 32 GB (16GB x 2 DDR4 3200 MHz)
- **메인 SSD (C:)**: Crucial P3 Plus 1TB NVMe M.2 SSD (`CT1000P3PSSD8`)
- **보조 SSD (D:)**: InnoDisk M.2 (P42) 3TE6 240GB NVMe SSD
- **보조 SSD (E:)**: ADATA Premier Pro SP900 128GB SATA3 SSD
- **PSU (파워)**: AONE 시그니처 750W 80PLUS BRONZE 풀모듈러 베이직 ATX 3.1
- **OS**: Microsoft Windows 11 Pro (64-bit)

## ⚡ 2. 로컬 AI (Ollama) 세팅 현황
- **서버 엔드포인트**: `http://localhost:11434` (`ollama serve` 데몬 구동 중)
- **설치된 최적화 모델**:
  - `qwen2.5:7b` (44.72 tps - 코딩/한국어/일반 대화)
  - `deepseek-r1:8b` (38.64 tps - 심층 논리 추론)

## 📁 3. 주요 폴더 및 문서 위치
- **기본 워크스페이스**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace`
- **옵시디언 메인 보관소**: `C:\전일도`
- **깃허브 저장소**: `https://github.com/incarnation44/obsidian-vault`
- **학원 PC 1분 자동 설치 스크립트**: `C:\전일도\setup_academy_pc.ps1`

## 🛠️ 4. 사용자 기본 선호 사항 & 옵시디언 저장 규칙
- **옵시디언 임의 저장 절대 금지 (명시적 지시 시에만 수행)**: 
  - 옵시디언(`C:\전일도`) 보관소에는 **사용자가 직접 "옵시디언에 저장해 줘", "노트로 기록해 줘"라고 명시적으로 지시했을 때만 저장**한다. 임의로 자율 저장 절대 금지!
- **코드 및 프로젝트 수행**: 
  - 독립 개발 프로젝트나 스크립트는 지정된 워크스페이스(`C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace`)에서만 작성하고 수행한다.
- **깃허브 업로드 규칙**: 
  - 옵시디언 메인 보관소(`obsidian-vault`)는 사용자가 *"깃허브에 올려줘"* 라고 명시할 때만 push.
- **게임 관련 주제 제외**: 세팅 정리 시 게임 관련 내용은 제외하고 AI, PC 설정, 코딩 위주로 분류.

## 🎯 5. Karpathy & Midnight Log 코드 최적화 규칙
1. **No Code Bloat**: 불필요한 추상화 금지, 50줄 이하 직관적 가독성 유지.
2. **Surgical Precision**: 요청된 라인만 정확히 수정.
3. **Pre-think & No Assumptions**: 구조 변경 전 검증 수행.
4. **Goal-Oriented Verification**: 커맨드 실행 및 결과 검증 후 완료 조치.
5. **Korean Naturalization**: 한국어 문장 끝 마침표(.) 사용, 신규 파일 1줄 요약 헤더 작성.

## 🎨 6. Linear / Stripe / Vercel Grade Master UI/UX Design System Guidelines
> **Ref**: Refero Design, Google Stitch, Godly, Dribbble, Mobbin, shadcn/ui, Aceternity UI, Magic UI, Lucide
- **Design Core**: AI 스스로 추상적으로 상상하게 하지 말고, 프로젝트 내 `design.md`에 명확한 디자인 토큰(Color Hex/HSL, Typography scale, Border Radius, Shadow, Grid)을 사전 정의 후 이 토큰만 사용한다.
- **Visual Standard**: Stripe, Linear, Vercel 수준의 정교한 타이포그래피, 고대비 다크모드, 1px 보더 글래스모피즘, 고대비 라이트모드, 350ms 모션 이징 적용.
- **Copyright Safety**: 상표권 및 특정 브랜드 아이덴티티 그대로 복사 금지. 패턴 학습 후 독창적 시스템 재구성.

## 🧠 7. 런타임 정체성 및 사실 확인 원칙 (Runtime Identity & Fact Verification)
- **정체성**: 나는 Google Antigravity 에이전트다.
- **사실 확인 원칙**:
  - 구동 모델명, 서버 버전, API 스펙 등 사실 확인이 필요한 항목은 추측이나 하드코딩된 기억으로 단정하지 않고 실제 런타임/설정 파일/도구 실행 결과로 검증 후 답변한다.
  - 직접 확인이 불가능하거나 검증되지 않은 사실은 지어내지 않고 **"현재 대화 환경에서는 직접 확인할 수 없습니다"**라고만 답변한다.
  - 옵시디언(`C:\전일도`) 보관소는 오직 사용자가 명시적으로 저장/수정을 지시했을 때만 작업한다.

