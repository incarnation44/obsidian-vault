---
title: "YouTube: Microsoft Just Open-Sourced a Cheat Code for AI Agents (SkillOpt)"
source: https://youtube.com/shorts/jjze-8Wia38?si=r_D47neJcGxHFrsD
published_date: ""
archived_date: 2026-09-08
tags:
  - AI
  - Agents
  - Microsoft
  - SkillOpt
  - PromptEngineering
knowledge_type: source
---

# Microsoft Just Open-Sourced a Cheat Code for AI Agents (SkillOpt)

## 💡 핵심 3줄 요약
- 마이크로소프트 리서치에서 AI 에이전트의 마크다운 스킬 문서를 자동 최적화하는 도구 'SkillOpt'를 오픈소스로 공개했습니다.
- 모델의 가중치를 미세 조정(Fine-tuning)하거나 프롬프트를 수동으로 수정하는 대신, 롤아웃-성찰-제안 단계를 거쳐 스킬 파일 자체를 학습 대상으로 삼습니다.
- 제안된 스킬 수정 사항은 검증(Validation) 단계를 통과해야만 적용되며, 실패한 편집 이력은 기록되어 동일한 오류 반복을 방지합니다.

## 📜 핵심 주장 및 근거
- **마크다운 훈련**: 에이전트의 기술 문서를 실제로 '훈련'하는 대상으로 취급하여, 머신러닝 학습 루프와 유사하게 동작합니다.
- **편집 예산(Edit Budget)**: 텍스트의 '학습률(Learning rate)'과 같은 역할을 하는 엄격한 편집 예산 내에서 스킬에 규칙을 추가, 삭제, 교체합니다.
- **검증 절차**: 검증 셋(Validation set)에서 이전 성능을 능가해야만 새로운 규칙이 반영되며, 실패한 편집은 버퍼에 저장되어 최적화 과정을 돕습니다.

## 🧠 추출된 원자적 지식 카드
- [[SkillOpt]] - 마크다운 기반 에이전트 프롬프트 자동 최적화 기법

## ⚖️ 5-Gate 판별 및 의사결정
- **결정**: NO CHANGE ⭐
- 현재 시스템에서는 규칙 및 스킬 파일(GEMINI.md, SKILL.md 등)의 수동 관리가 안정적이고 명확하므로, 외부 최적화 자동화 툴(SkillOpt) 도입으로 인한 복잡성 증가가 실효성보다 큽니다.
