# 🎓 Python 기반 AI 입문 과정 시험대비 핵심정복 마스터교재

> **출처 및 기준:** [비솔 AI Campus] Python 기반의 AI 입문 과정 공식 30강 전 단원 (01-01 ~ 08-01)  
> **PDF 교재 경로:** `C:\Users\ildoc\OneDrive\바탕 화면\문서\Python_AI_시험대비_마스터교재.pdf`

---

## 🧭 [제1장. 인공지능 개론 및 패러다임의 변화 (01-01 ~ 01-03)]
* **지능의 정의:** 환경을 인식하고, 지식을 학습하여 목표를 달성하기 위해 합리적으로 판단/추론하는 능력.
* **튜링 테스트(Turing Test, 1950):** 앨런 튜링 제안. 인간 감별사가 기계와 텍스트로 대화하여 인간인지 기계인지 구별하지 못하면 기계에 지능이 있다고 판정.
* **강인공지능(AGI) vs 약인공지능(Narrow AI):**
  * 약인공지능: 바둑(알파고), 자율주행, 번역 등 특정 도메인 문제만 해결. (현재의 모든 AI)
  * 강인공지능: 인간과 동등하거나 그 이상의 범용적 자의식과 문제 해결 능력을 갖춘 인공지능.
* **기호주의(Symbolism) vs 연결주의(Connectionism):**
  * 기호주의: 사람이 직접 If-Else 지식 규칙을 하드코딩 (전문가 시스템).
  * 연결주의: 뇌세포의 시냅스 연결망을 본떠 데이터로부터 가중치를 학습 (현대 딥러닝).
* **🚨 시험 족보:** 1956년 다트머스 회의에서 존 매카시가 '인공지능(AI)' 용어를 공식 제정함.

---

## 🧭 [제2장. 파이썬 프로그래밍 환경 및 셈 지능 (02-01 ~ 02-04)]
* **Colab vs Anaconda:**
  * Google Colab: 웹 기반, 무료 T4/V100 GPU 지원, 팀 공유 용이.
  * Anaconda: 로컬 환경, conda 가상환경 격리로 라이브러리 버전 충돌 방지.
* **NumPy 벡터화 연산 (Vectorization):**
  * 파이썬의 `for` 반복문 대비 C 언어 내부의 SIMD 명령어와 연속 메모리를 사용하여 수십~수백 배 빠른 수치 연산 지원.
  * `A * B`: 요소별 곱(Element-wise multiplication)
  * `A @ B` 또는 `np.dot(A, B)`: 행렬 곱(Dot product) — 시험 단골 구분 문제!

---

## 🧭 [제3장. 기계학습 기초, 데이터 표현 및 성능 평가 (03-01 ~ 03-05)]
* **학습 유형:**
  * 지도학습 (회귀: 연속값 예측 / 분류: 이산 범주 판별)
  * 비지도학습 (군집화 K-Means, 차원축소 PCA)
  * 강화학습 (상태, 행동, 보상 체계)
* **데이터셋 분할:** Train(60~80%), Validation(10~20%), Test(10~20%).
* **분류 모델 평가 지표 4대 공식 (🚨 필수 암기):**
  * **정확도(Accuracy):** $\frac{TP + TN}{TP + TN + FP + FN}$ (클래스 비율 균형 시)
  * **정밀도(Precision):** $\frac{TP}{TP + FP}$ (스팸 메일 필터링 등 FP가 치명적일 때)
  * **재현율(Recall / 민감도):** $\frac{TP}{TP + FN}$ (암 환자 진단 등 FN이 치명적일 때)
  * **F1-Score:** $2 \times \frac{\text{Precision} \times \text{Recall}}{\text{Precision} + \text{Recall}}$ (불균형 데이터 필수)

---

## 🧭 [제4장. 인공 신경망의 태동, 퍼셉트론과 오류 역전파 (04-01 ~ 04-05)]
* **단층 퍼셉트론과 XOR 한계:**
  * 단층 퍼셉트론은 선형 분리 가능(Linearly Separable)한 AND, OR만 해결 가능.
  * XOR 문제는 직선 하나로 나눌 수 없어 1차 AI 겨울 초래.
  * **해결책:** 은닉층을 둔 다층 퍼셉트론(MLP)과 비선형 활성화 함수 도입.
* **활성화 함수 비교:**
  * `Sigmoid`: 층이 깊어지면 미분값이 0에 수렴하여 기울기 소실(Vanishing Gradient) 발생.
  * `ReLU`: 양수 영역에서 기울기가 1로 유지되어 기울기 소실을 극복한 현대 표준 활성화 함수.
  * `Softmax`: 출력 노드 확률 합을 1.0으로 만들어 다중 클래스 분류에 사용.
* **오류 역전파(Backpropagation):** 출력층 오차에서 출발하여 연쇄 법칙(Chain Rule)을 적용해 각 가중치의 기울기를 역방향으로 전파하여 갱신.

---

## 🧭 [제5장. 딥러닝 실전과 TensorFlow 프로그래밍 (05-01 ~ 05-05)]
* **손실 함수 매칭:**
  * 회귀: `mean_squared_error` (MSE)
  * 이진 분류: `binary_crossentropy` (출력층 노드 1, activation='sigmoid')
  * 다중 분류: `sparse_categorical_crossentropy` (정수 라벨) / `categorical_crossentropy` (원-핫 라벨)
* **옵티마이저 (Optimizer):**
  * `SGD` ➡️ `Momentum`(관성 추가) ➡️ `RMSprop`(적응형 학습률) ➡️ `Adam`(모멘텀+RMSprop 장점 결합, 표준 원픽).
* **과적합 방지 4대 전략:** 드롭아웃(Dropout), 데이터 증강(Augmentation), 가중치 규제(L1/L2), 조기 종료(EarlyStopping).

---

## 🧭 [제6장. 합성곱 신경망 (CNN, Computer Vision) (06-01 ~ 06-04)]
* **CNN 핵심 레이어:**
  * `Conv2D`: 커널(필터)을 이동(Stride)하며 이미지 공간 특징 추출.
  * `MaxPooling2D`: 가로/세로 해상도를 절반으로 줄여 파라미터 수 절감 및 이동 불변성 획득 (가중치 학습 없음).
* **출력 크기 공식:** $O = \frac{W - F + 2P}{S} + 1$ (W:입력크기, F:필터크기, P:패딩, S:스트라이드).
* **전이 학습(Transfer Learning):** ImageNet 등으로 사전학습된 모델(VGG, ResNet)의 가중치를 가져와 출력층만 미세 조정(Fine-Tuning).

---

## 🧭 [제7장 & 8장. 생성 모델(GAN, Autoencoder) 및 총정리 (07-01 ~ 08-01)]
* **오토인코더 (Autoencoder):** 입력 $X$를 압축(Encoder)하여 잠재 공간(Latent Space, $Z$)을 거쳐 복원(Decoder). 노이즈 제거 및 이상치 탐지에 사용.
* **GAN (생성 적대 신경망):**
  * 생성자(Generator): 판별자를 속이려고 진짜 같은 가짜 이미지 생성.
  * 판별자(Discriminator): 진짜와 가짜를 구별.
  * 두 네트워크의 Minimax 게임을 통해 고화질 이미지 생성.
