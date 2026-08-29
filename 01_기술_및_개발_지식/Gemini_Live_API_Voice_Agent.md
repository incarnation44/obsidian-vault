---
tags:
  - AI
  - Gemini
  - VoiceAgent
  - API
  - 코딩
---

# 🎬 영상 제목: Build a real-time voice AI agent with Gemini Live API

## 📌 아카이빙 메타데이터
- **1) 원본 출처**: https://youtu.be/pFc-HcUgFgY?si=iSlKVMDuipwGalx7
- **2) 원본 정보 발행일자**: 미상 (YouTube 참조)
- **3) 내 보관소 등록일자**: 2026-08-30

## 💡 핵심 요약
텍스트를 음성으로 변환(TTS)하는 단순한 방식이 아닌, 양방향(Audio-to-Audio) 실시간 음성 에이전트를 'Gemini Live API'를 활용해 구축하는 방법과 핵심 아키텍처를 소개하는 영상입니다.

## 📌 주요 내용 및 타임라인 포인트
- **Part 1. 기존 AI 보이스와 Live Voice의 차이점**:
  - **기존 TTS(Text-to-Speech)**: 텍스트를 음성으로만 변환하는 단방향 시스템 (듣지 못함).
  - **Gemini Live API**: Audio-to-Audio 기반의 양방향 통신. 사용자의 톤, 억양, 일시정지, 감정을 실시간으로 듣고 파악하며, 답변이 완전히 완성되기 전부터 말을 시작(Streaming)할 수 있어 실제 통화와 같은 자연스러운 대화가 가능.
- **Part 2. 아키텍처 구성 요소 (3가지)**:
  - **1) 브라우저(Browser)**: 사용자의 마이크 소리를 수집하고 AI의 응답 오디오를 재생.
  - **2) Gemini Live (모델)**: 실시간 오디오 추론 모델.
  - **3) 소규모 백엔드(Backend)**: Gemini와 브라우저 사이에서 열린 연결 상태를 유지하며 오디오 데이터를 중계. 일반적인 1회성 HTTP 요청 대신 **웹소켓(WebSocket)**을 사용하여 양방향 실시간 오디오 스트리밍을 구현.
