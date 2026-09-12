---
source_url: https://youtu.be/_IY6dwg4dvY?si=LkzXOlffIB9WcWUl
ingested: 2026-09-12
sha256: n/a (transcript provided inline by user)
---

# Video: AI 고수들이 DoRA로 갈아타는 이유 (CODER X DOX)

DoRA 논문(Weight-Decomposed Low-Rank Adaptation) 해설 영상 요약. 영상에서 제시한 수치 중 일부(랭크 8 붕괴 37점차 등)는 영상 자체도 후속 연구에서 과장 가능성을 지적했으므로 그대로 인용 시 주의.

## 영상 핵심 주장

1. LoRA의 고질 문제: 풀 파인튜닝 대비 성능이 항상 조금 모자람. 원인을 파라미터 수로만 봤던 기존 해석에 의문 제기.
2. 가중치를 크기(magnitude)와 방향(direction)으로 쪼개 측정했더니 풀 파인튜닝은 둘 중 하나만 움직임(상관 -0.62), LoRA는 둘이 같이 움직임(상관 +0.83).
3. DoRA 처방: 크기는 작은 벡터로 직접 학습, 방향만 LoRA에 맡김. 추가 파라미터는 0.01% 수준(LLaMA 기준 LoRA 0.83%, DoRA 0.84%).
4. 학습 끝나면 LoRA처럼 하나로 합치니 추론 추가 비용 0.
5. 대가: 학습 시 메모리·시간 추가 소요. DoRA가 LoRA보다 약 20% 느리다는 외부 측정 언급. 메모리 절약 트릭으로 LLaMA 7B 기준 37.3GB를 28.2GB로 줄였다고 소개.
6. 성능 수치(영상 인용, 상식추론 8태스크 평균): LLaMA 7B LoRA 74.7 → DoRA 78.4, LLaMA3 8B 80.8 → 85.2. 랭크 절반 DoRA도 LoRA 상회 주장.
7. QDoRA(4비트 양자화 + DoRA): 수학 데이터 학습에서 QLoRA 0.32, QDoRA 0.56, 풀 파인튜닝 0.51 인용.
8. SDXL 스타일 학습 예시: 둥근 사각형 프레임·레고 로고 같은 세부 특징을 DoRA만 포착.
9. 단, 랭크 8 붕괴(로라 40.7 vs 도라 77.9)는 러닝레이트 튜닝 불균형 탓일 가능성. 후속 연구에서 제대로 튜닝하니 격차가 1~2%로 줄었다고 영상도 정정.
