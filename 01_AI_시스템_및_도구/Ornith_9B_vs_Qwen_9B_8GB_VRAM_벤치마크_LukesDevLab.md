---
title: "Ornith 9B vs Qwen 9B: 8GB VRAM 코딩 벤치마크 및 컨텍스트 한계 — Luke's Dev Lab"
aliases: ["Ornith 9B", "Qwen 9B", "8GB VRAM 벤치마크", "Luke's Dev Lab"]
category: "01_AI_시스템_및_도구"
source: "https://youtu.be/qLFNNRxwd5s"
published_date: "2026-07-06"
created_date: "2026-09-12"
tags: ["AI", "Benchmark", "VRAM", "Coding", "Ornith", "Qwen", "Context"]
knowledge_type: source
---

# Ornith 9B vs Qwen 9B: 8GB VRAM 코딩 벤치마크 및 컨텍스트 한계 — Luke's Dev Lab

## 📌 아카이빙 필수 메타데이터
- **원본 출처**: https://youtu.be/qLFNNRxwd5s
- **원본 정보 발행일자**: 2026-07-06
- **내 보관소 등록일자**: 2026-09-12
- **채널명**: Luke's Dev Lab

---

## 💡 핵심 요약 (Level 0)
1. **8GB VRAM의 스위트스팟 (No-Offload)**: 8GB VRAM GPU(예: RX 6600) 환경에서 메모리 스왑이나 CPU 오프로딩 없이 VRAM에 100% 안착하여 최고 속도(36~37 tok/s)를 낼 수 있는 마지노선이 '9B 모델의 4-bit 양자화(Q4)' 체급임을 증명함.
2. **소형 모델의 '기억 상실' 치명타**: Qwen과 Ornith 모두 문서의 중간 내용을 찾아내는 'Needle in a Haystack' 테스트에서 처참하게 실패함. 스펙상 128K 컨텍스트를 지원하더라도, 9B 체급의 뇌 용량으로는 긴 문맥을 버티지 못하고 중간 내용을 잊어버리는(Lost in the middle) 한계가 명확함.
3. **파이썬 코딩 및 에이전시 (Ornith의 완승)**: Qwen 3.5 기반으로 파인튜닝된 Ornith 9B가 도구 호출(Tool Calling) 안정성과 파이썬 코딩(Human Eval 91%), 디버깅 실전(Expense Tracker)에서 원본인 Qwen 9B를 압도함. (Qwen은 UI 디자인은 예뻤으나 문법이 깨져 도구 호출을 실패하고 무한 디버깅 루프에 빠짐).

---

## 📜 상세 분석 및 타임스탬프 근거 (Level 1 Claims)

### 1. 8GB VRAM 최적 스펙 및 성능 [00:12~02:49]
- **테스트 환경**: 8GB VRAM을 가진 유저를 위한 벤치마크로, 모델은 Ornith 9B와 Qwen 3.5 9B, 양자화 포맷은 모두 `Q4_K_M`(4-bit)을 사용함. 이 세팅 시 모델이 온전히 VRAM에 올라감.
- **성능 (Speed)**: 두 모델 모두 컨텍스트에 상관없이 초당 36~37 토큰(36~37 tok/s)의 쾌적한 Decode(생성) 속도를 보여줌. (오프로딩이 없기 때문에 PCIe 병목이 발생하지 않음).

### 2. 거대 컨텍스트 망각 (Needle in a Haystack) [02:51~04:40]
- 방대한 리눅스 커널 문서(64K, 128K, 256K) 중간에 암호를 숨겨두고 찾게 하는 테스트 진행.
- 두 모델 모두 문서의 시작과 끝부분은 그나마 찾았으나, **문서의 25%, 50%, 75% 지점에 있는 데이터는 거의 찾아내지 못하고 환각을 일으킴**.
- 테스터 코멘트: "35B MoE나 27B Dense 모델로 같은 테스트를 하면 훨씬 잘 찾는다. 9B 모델은 방대한 컨텍스트 처리에 끔찍하다(Terrible)."

### 3. 코딩 및 에이전트 능력 (Agency & Coding) [04:42~16:49]
- **Agency (도구 호출)**: Ornith(91%) > Qwen. Qwen은 지능이 모자라다기보다는, 도구를 호출할 때 마크다운 문법(Syntax)을 계속 틀려서 샌드박스 시스템이 인식을 못해 실패 처리됨.
- **Python 코딩 (Human Eval)**: Ornith(148개 패스, 91%) > Qwen(143개 패스, 87%). 파이썬 로직에서는 Ornith가 우위.
- **실전 웹앱 만들기**: 
  - 지출 관리자(Expense Tracker) 개발 시 Ornith는 빠르고 뭉툭한 UI로 동작하는 코드를 완성한 반면, Qwen은 UI는 예뻤으나 카테고리 드롭다운 버그를 고치지 못하고 무한 루프에 빠져 결국 포기함.

---

## 🛠️ AI(나) 및 3-PC 사용자 환경 적용점 (Level 2 System Actions)

1. **메인 데스크톱 (PC B: RX 6600 8GB)의 워크플로우 분리 의사결정 (ADR 적용)**:
   - 이 영상은 8GB VRAM 유저에게 뼈아픈 진실을 확인시켜 줌. 9B 체급(Q4)은 VRAM에 완벽히 들어가 초당 36토큰의 광속 코딩을 가능하게 하지만, 프롬프트가 길어지면 심각한 건망증(Lost in the middle)을 앓음.
   - **라우팅 규칙 (Routing Rule) 확정**:
     - **방대한 문서 요약 / 대형 코드베이스 탐색 (10K 이상의 컨텍스트)**: 9B 모델을 절대 쓰지 않는다. 이전 지식([[KV_캐시_양자화와_MoE_특화_CPU_오프로딩]])을 결합하여, 느리더라도 **35B 체급 모델을 CPU에 오프로딩**하여 읽힌다. (거대 모델은 문맥을 놓치지 않음).
     - **단일 파일 디버깅 / 빠르고 정밀한 파이썬 함수 작성 (단일 샷)**: **9B Q4 모델(예: Ornith 9B)**을 온전히 VRAM에 올려 37 tok/s의 속도로 빠르게 타격하고 빠진다.
2. **도구 호출(Tool Calling) 문법 파싱의 강건성**:
   - Qwen 9B가 에이전시 테스트에서 실패한 이유는 "생각을 못해서"가 아니라 "문법(Syntax)이 깨져서"였음. 이는 내가(`ORCHESTRATOR`) 서브에이전트나 로컬 모델의 JSON/XML 출력을 파싱할 때, 엄격한 잣대로 에러를 던지지 말고 정규식 등을 통해 유연하게 의도를 추출(Robust Parsing)해야 한다는 점을 시사함.

---

## 🔗 관련 문서 및 위키 링크
- [[9B_이하_소형_모델의_대규모_컨텍스트_망각_한계]]
- [[llama_cpp_8GB_VRAM_35B_오프로딩_최적화_AIProgBr]]
- [[1-bit_양자화와_하이브리드_오프로딩_트레이드오프]]
