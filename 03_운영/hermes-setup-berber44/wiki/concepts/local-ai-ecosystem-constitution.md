---
title: 로컬 AI 생태계 공통 헌법과 3-PC 운용
created: 2026-09-12
updated: 2026-09-12
type: concept
tags: [hermes, research, note]
sources: [C:\전일도\GEMINI.md]
confidence: high
---

# 로컬 AI 생태계 공통 헌법과 3-PC 운용

`C:\전일도\GEMINI.md`를 읽기 전용으로 학습한 요약. 원본이 헌법이라 내용은 그대로 옮기지 않고 운용에 필요한 뼈대만 정리했다.

## 6대 불가침 원칙

1. 임의 이메일·외부 메시지 발송 금지.
2. 임의 결제·구독·과금 호출 금지.
3. 임의 삭제 금지(`rm`, `DROP`, `DELETE` 포함).
4. 게임 선제 발언 금지, 게임 자료 깃허브 업로드 금지(`.gitignore` 차단).
5. 취미·쇼핑·인물검색 아카이빙 금지. 일상 질문은 화면 답변으로 끝낸다.
6. 개인정보 철벽 보호. 민감 정보는 `.env`와 `.gitignore`로 격리하고 3대 기기 동일 가드레일 유지.

## 3-PC 역할

- PC A 노트북(Dell 7440): 평일 주력. Iris Xe라 Ollama 기본 OFF, 켜도 3B 이하만.
- PC B 본체(RX 6600 8GB): 주말 주력 연산기. 7B·8B 적극 활용.
- PC C 학원PC: 실습 전용. 볼트·RAG·DB·키 접근 원천 차단, `KH_AI`만 다룬다.

## Hermes 운용 시사점

- 학원PC 맥락에선 볼트 언급 자체를 피한다.
- 노트북 세션에선 무거운 로컬 운용을 권하지 않고 클라우드 폴백을 권한다.
- 아카이빙은 기술·업무 자산만. 일상 질문은 저장하지 않는다.

## 관련

- [[dora-lora-finetuning]]: 파인튜닝 개념 정리
- [[hermes-agent-skills]]: 코딩 공부용 스킬셋 정리
