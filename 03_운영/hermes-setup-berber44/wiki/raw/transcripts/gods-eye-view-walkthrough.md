---
source_url: https://youtu.be/o_FJ1NIH9yw?si=X4dwzZpNRSsGebUt
ingested: 2026-09-12
---

# Video: God's Eye View Blew Up. Here's What You Can Do With It.

Bilawal Sidhu가 만든 오픈소스 'God's Eye View' — 실시간 지구 디지털 트윈(항공기, 선박, 화재, 지진, CCTV, 해저 케이블 등) 웹 앱 전체 워크스루.

## 설치 방법 (비코더 포함 모두)
1. **Pinokio 원클릭 설치** (추천): https://pinokio.co/apps/github-com-bilawalsidhu-gods-eye-view → Pinokio 8.2+ 설치 후 원클릭.
2. **AI 코딩 에이전트 위임**: GitHub 리포를 Claude Code, Codex, Cursor, AntiGravity 등에 던지고 설명의 프롬프트 복붙.

## 핵심 기능 및 레이어
- **항공기 추적 (Flights)**: ADS-B 수신기 수만 대 자원봉사 네트워크로 실시간 민간/군용기 트래킹. 흰색=민간, 노랑=군용.
- **조종석 뷰 (Cockpit View)**: 항공기 선택 → 'Ride Along'으로 1인칭 조종석 시점 비행 체험.
- **음성 제어 (Voice Control)**: "Show me flights over Tokyo" 등 자연어로 지도 조작. OpenAI Realtime API / Whisper / TTS 연동.
- **선박 추적 (Ships)**: AIS 데이터로 실시간 선박 위치/항로 확인.
- **공공 CCTV (Traffic Cameras)**: 전 세계 교통/공공 카메라 피드 실시간 오버레이.
- **화재/지진 (Fires, Earthquakes)**: NASA FIRMS 화재 핫스팟, USGS 실시간 지진 데이터.
- **물리적 인터넷 (Subsea Cables)**: 해저 광케이블 맵, 데이터 센터, 인터넷 인프라 가시화.
- **영역 51 이스터에그**: 재미 요소.
- **카메라 투어 녹화**: 카메라 피드 연결해 투어 영상 제작 가능.

## 파워업(Power Up) 패널 — 키 관리
- 우하단 'Power Up' 클릭 → 'Manage'에서 API 키 로컬 입력:
  - **Cesium Ion Token** (무료 커뮤니티 계정): Google 3D Tiles(포토리얼 3D) 활성화.
  - **Google Maps API Key** (선택, 신용카드 필요): 2D 라벨/하이브리드 맵.
  - **OpenAI API Key**: 음성 제어(Voice), GPT-4o Realtime.
  - **Mapbox Token** (선택): 대체 맵 스타일.
- 키는 로컬 브라우저 저장소에만 저장, 서버 전송 없음.

## 데이터 소스 (오픈/커뮤니티 기반)
- ADS-B Exchange, OpenSky Network (항공기)
- AISHub, MarineTraffic (선박)
- NASA FIRMS (화재), USGS (지진)
- Submarine Cable Map (해저 케이블)
- 다양한 공공 CCTV 피드
- 전체: https://github.com/bilawalsidhu/gods-eye-view/blob/main/DATA_SOURCES.md

## 확장성 — 직접 도구 만들기
- 오픈소스라 AI 코딩 에이전트에 "이 기능 추가해줘" 하면 자연어로 기능 확장 가능.
- 이미 기여된 실험적 레이어: 자동 번호판 판독기(ALPR), 소프트웨어 정의 라디오(SDR) 연동(경찰 무전 청취 등).
- 기여 가이드: CONTRIBUTING.md

## 호스티드 버전 수요
- 설치 없이 웹에서 바로 쓰는 호스티드 버전 요구 많음. 상용 API 교체/유료 플랜 검토 중.

---

## 요약 인사이트 (Minto Pyramid)
**"오픈소스 실시간 지구 디지털 트윈 'God's Eye View'는 항공기/선박/화재/지진/CCTV/해저케이블을 한 화면에 통합했으며, Pinokio로 비코더도 원클릭 실행 가능하고, 음성 제어와 3D 포토리얼을 API 키만 넣으면 즉시 활성화된다. AI 에이전트로 기능 확장도 용이하다."**

## 파인만 비유 (ELI5)
> 구글 어스에 **실시간 레이더**를 달아놓은 거라고 보면 됩니다.  
> 비행기, 배, 불, 지진, 심지어 바닷속 인터넷 선까지 **지금 이 순간 어디에 있는지** 다 보입니다.  
> 음성으로 "도쿄 위 비행기 보여줘"라고 말하면 바로 날아갑니다.  
> 설치도 Pinokio라는 '앱스토어'에서 버튼 한 번이면 끝납니다.
