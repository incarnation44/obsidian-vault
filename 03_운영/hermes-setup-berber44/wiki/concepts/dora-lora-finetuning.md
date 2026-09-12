---
title: DoRA와 LoRA, 효율 파인튜닝 이해
created: 2026-09-12
updated: 2026-09-12
type: concept
tags: [research, dev, note]
sources: [raw/transcripts/dora-paper-review.md]
confidence: medium
---

# DoRA와 LoRA, 효율 파인튜닝 이해

거대 모델 전체를 다시 학습시키지 않고 일부만 손보는 기법(PEFT) 중 LoRA와 DoRA를 정리한 개념 페이지. 방법론 자체는 논문·공식 구현으로 확인됐고^[PMLR DoRA proceedings](https://proceedings.mlr.press/v235/liu24bn.html) ^[NVlabs/DoRA GitHub](https://github.com/NVlabs/DoRA), 세부 벤치 수치는 영상 인용이라 `confidence: medium`으로 둔다.

## LoRA 한 줄 요약

큰 가중치는 얼려두고 변화분만 작은 행렬 둘(A·B)로 배운다. `W = W0 + BA` 꼴이라 학습 뒤 하나로 합치면 추론 비용이 안 는다.

## DoRA가 던진 질문

풀 파인튜닝과 LoRA의 차이는 파라미터 수가 아니라 배우는 방식에 있지 않을까. 가중치를 화살표로 보면 길이(크기)와 각도(방향)가 있다. 풀 파인튜닝은 둘 중 하나만 골라 움직이는데 LoRA는 둘이 묶여 같이 움직인다. 핸들을 꺾으면 엑셀도 같이 밟히는 차와 비슷하다.

## DoRA 처방

사전학습 가중치를 크기와 방향으로 나눈다. 크기는 컬럼당 숫자 하나로 직접 배우고 방향만 LoRA에 맡긴다. 추가 파라미터는 0.01% 수준이라 추론 시 합치면 비용이 0이다.

## 실무 관점 장단

- 장점: 낮은 랭크에서도 안정적이라는 보고. 양자화 병행(QDoRA) 시에도 선방했다는 인용.
- 단점: 학습은 공짜가 아니다. 메모리와 시간이 LoRA보다 든다. 영상도 20% 느리다는 외부 측정을 소개했다.

## 노트북 기준 판단

Iris Xe 내장그래픽만 있는 환경에서 7B급 파인튜닝은 무리다. DoRA 메모리 절약 트릭을 써도 28GB대는 전용 GPU 영역이라 로컬 실습 대상이 아니다. 개념 이해용으로만 가져가고 손으로 돌려볼 생각은 접는 게 맞다.

## 관련

- [[hermes-agent-skills]]: 코딩 공부용 스킬셋 정리
- [[ai-coding-skills-landscape]]: 코딩 도구 생태계 지도
