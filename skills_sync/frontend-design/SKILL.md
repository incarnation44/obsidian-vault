---
name: frontend-design
description: "Human-grade Frontend Design & Anti-AI Slop Standard. Eliminates generic AI templates, banned cliché tropes (purple gradients, headline pill dots, icon bento boxes), and enforces Pretendard typography, tactile surface depth, and luxury agency aesthetics."
---

# 🎨 Human-Grade Frontend Design & Anti-AI Slop Standard

인간 수석 프로덕트 디자이너 및 외주 에이전시 수준의 최상급 UI/UX 웹사이트, 인터페이스, PDF 문서를 제작하는 표준 지침서입니다.

---

## 🚫 1. 절대 금지된 AI 디자인 10대 클리셰 (Banned AI Tropes)

다음 요소는 화면에 등장하는 즉시 "저품질 AI가 찍어낸 사이트"라는 느낌을 주므로 **전면 금지**합니다:

1. ❌ **어두운 배경에 보라색/바이올렛 폰트 및 네온 글로우 (Purple on Dark)**
2. ❌ **헤드라인 키워드에 무지개색/보라색 CSS 그라데이션 텍스트 (Gradient Keywords)**
3. ❌ **헤드라인 바로 위에 깜빡이는 점(Pulsing Dot) 달린 알약 배지 (Headline Biscuit Pills)**
4. ❌ **무의미한 아이콘으로 도배된 벤토 박스 (Icon-Stuffed Bento Boxes)**
5. ❌ **질감이나 깊이감 없이 플랫하고 밋밋한 카드 (Textureless Flat Surfaces)**
6. ❌ **자간(letter-spacing) 조절 없는 거대하고 뚱뚱한 폰트**
7. ❌ **카드 안에 카드가 3개 이상 중첩된 과도한 카드 남발 (Over-Nested Cards)**
8. ❌ **기계적인 기본 폰트(Arial, Times, 기본 Sans-serif) 방치**
9. ❌ **어색한 직역투의 과장 광고 문구 ("당신의 여정을 혁신하세요" 등)**
10. ❌ **배경에 깔리는 거미줄 파티클 메시나 방사형 그리드 패턴**

---

## 💎 2. 프로페셔널 인간 디자이너 5대 황금 원칙

### ① 폰트 & 타이포그래피 (Pretendard First)
* **기본 폰트**: 한국어와 영문 모두 **`Pretendard`** 폰트를 최우선 적용합니다.
* **자간(Letter-spacing)**: 헤드라인은 반드시 `-0.02em ~ -0.03em`으로 타이트하게 조여 세련된 인상을 만듭니다.
* **행간(Line-height)**: 본문 텍스트는 `1.6 ~ 1.75`로 넉넉한 호흡을 주어 가독성을 극대화합니다.

```html
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
```

### ② HSL 기반 맞춤형 세련된 컬러 팔레트
* 검정색 대신 딥 네이비/차콜(`hsl(222, 47%, 11%)`), 화이트 대신 크림/소프트 그레이(`hsl(210, 40%, 98%)`)를 베이스로 사용하여 눈의 피로를 덜고 고급감을 부여합니다.
* 브랜드 메인 컬러 1개와 뉴트럴 톤 3개 이내로 절제된 배색을 유지합니다.

### ③ 촉각적 깊이감 (Tactile Surface Depth)
* 단순 단색 배경 대신 미세한 보더(`border: 1px solid rgba(255, 255, 255, 0.08)`), 다층 박스 섀도우(`box-shadow: 0 4px 20px -2px rgba(0,0,0,0.05)`), 부드러운 블러 백드롭(`backdrop-filter: blur(12px)`)을 사용합니다.

### ④ 살아 숨쉬는 마이크로 애니메이션
* 버튼 호버 시 단순 색상 변경이 아닌 부드러운 스케일 업(`transform: translateY(-2px)`), 은은한 광택 전환(`transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1)`).
* 스크롤 시 섹션이 뚝딱 뜨지 않고 부드럽게 페이드인되며 차오르는 뷰포트 인터랙션.

### ⑤ 철저한 모바일 반응형 완성도
* 단순 너비 축소가 아니라 모바일 전용 터치 영역(최소 48px 이상), 햄버거 메뉴 오버레이, 하단 고정 CTA 버튼을 완벽 배치합니다.
