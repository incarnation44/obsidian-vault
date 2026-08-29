---
tags:
  - AI
  - JAX
  - GPU
  - 분산학습
  - 딥러닝
---

# 🎬 영상 제목: Scale JAX models to multi-GPU systems

## 📌 아카이빙 메타데이터
- **1) 원본 출처**: https://youtu.be/Ujwm_CCCn3s?si=YpTBh_EpY3mt7Y8x
- **2) 원본 정보 발행일자**: 미상 (YouTube 참조)
- **3) 내 보관소 등록일자**: 2026-08-30

## 💡 핵심 요약
복잡한 통신 코드(Communication code)를 새로 작성할 필요 없이, 배열(Array)의 배치(Placement) 정보만 명시하여 JAX 모델을 멀티 GPU 시스템으로 쉽게 확장(Data Parallelism 등)하는 4가지 핵심 개념을 설명하는 튜토리얼입니다.

## 📌 주요 내용 및 타임라인 포인트
- **JAX 멀티 GPU 스케일링의 철학**:
  - 학습 코드를 갈아엎는 것이 아니라, 배열(데이터/파라미터)을 어느 GPU에 위치시킬지(Placement)만 정의하면 JAX가 알아서 병렬 처리 및 그래디언트 동기화 연산을 삽입해 줍니다.
- **데이터 병렬처리 (Data Parallelism)**:
  - 가장 기본적인 스케일링 방법으로, 전체 배치(Batch) 데이터를 쪼개서 각 GPU에 할당하고, 역전파 시 그래디언트를 평균 내어 모든 GPU의 모델 가중치(Weight)를 동일하게 동기화합니다.
- **멀티 GPU 처리를 위한 4가지 핵심 개념**:
  1. **Mesh**: 연산에 참여할 기기(디바이스)들을 정의합니다.
  2. **Partition spec**: 데이터를 어떻게 쪼갤지(Split) 설명합니다.
  3. **Name sharding**: 기기와 분할 방식을 결합한 '배치 계획(Plan)'을 만듭니다.
  4. **Device put**: 실제 데이터를 해당 계획에 맞게 기기들에 배치(Apply)합니다.
- **검증 및 세밀한 제어(Debugging & Control)**:
  - `jax.debug.visualize_array_sharding`을 사용해 배치가 잘 쪼개졌는지, 가중치가 잘 복제되었는지 눈으로 확인할 수 있습니다.
  - 실험 시에는 **자동 샤딩(Automatic sharding)**을 우선 사용하되, 디버깅이나 정밀한 제어가 필요할 때는 기기별 로컬 데이터를 직접 제어하는 `shard_map`과 명시적 평균 함수 `pmean`을 사용하는 것이 좋습니다.
