---
title: SkillOpt
tags:
  - AI
  - PromptEngineering
  - Agent
knowledge_type: concept
---

# SkillOpt

마이크로소프트 리서치에서 오픈소스로 공개한 AI 에이전트 성능 최적화 도구.
모델의 가중치를 미세 조정(Fine-tuning)하거나 프롬프트를 수동으로 수정하는 대신, **에이전트가 사용하는 마크다운 형태의 스킬(Skill) 문서를 훈련 대상으로 취급**하여 자동으로 최적화하는 방식을 제안한다.

## 핵심 메커니즘
1. **롤아웃(Rollout)**: 에이전트가 현재의 스킬 파일로 일련의 작업을 수행하고, 주고받은 메시지와 도구 호출, 최종 점수 등을 모두 기록한다.
2. **성찰(Reflection)**: 별도의 최적화 모델(Optimizer model)이 성공과 실패 사례를 분석하여 재사용 가능한 패턴과 구체적인 규칙을 도출한다.
3. **제안(Proposal)**: 엄격한 편집 예산(Edit budget, 텍스트 최적화의 학습률과 같은 역할) 하에 스킬 파일의 텍스트(규칙 추가, 삭제, 대체 등) 수정을 제안한다.
4. **검증(Validation)**: 제안된 스킬 문서가 검증 셋(Validation set)에서 더 나은 성능을 보여야만 최종적으로 반영된다. 기각된 제안은 버퍼에 저장되어 최적화기가 동일한 실수를 반복하지 않도록 한다.

## 출처
- [[Youtube_Microsoft_SkillOpt]]
