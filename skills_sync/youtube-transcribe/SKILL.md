---
name: youtube-transcribe
description: Ultra-fast (1-second) YouTube transcript fetcher & summarizer. Use this skill whenever the user shares a YouTube video/Shorts URL to instantly extract full spoken text and generate crisp summaries without heavy audio downloading.
---

# ⚡ Ultra-Fast 1-Second YouTube Transcript & Summarizer

This skill extracts full transcripts directly from YouTube's transcript API in **under 1 second** without heavy audio downloading or slow local STT rendering.

Grok Bot을 기다리지 마라. 유튜브 요약은 Antigravity가 즉시 수행한다.

## 🚀 When to Use
- Whenever the user posts a YouTube URL (`youtube.com/watch` or `youtube.com/shorts/` or `youtu.be`).
- Do NOT ask for permission or prompt the user.
- Run the instant transcript script immediately and summarize.

## 🛠️ How to Execute

실존 경로 (추측 금지):

1. First, write the YouTube URL into the fixed scratch file: `C:\Users\ildoc\.gemini\antigravity\scratch\target_yt.txt` using `write_to_file`.
2. Then execute the fixed python command (with NO changing URL arguments so permission is permanently remembered):

```powershell
python "C:\Users\ildoc\.gemini\config\skills\youtube-transcribe\scripts\instant_transcript.py"
```

보조 스크립트(오디오 STT, 필요 시): `C:\Users\ildoc\.gemini\config\skills\youtube-transcribe\scripts\transcribe.py`

## 📋 Response Format (Direct to User)
1. **🎬 영상 제목 & 채널명**
2. **💡 핵심 3줄 요약**
3. **📌 주요 내용 및 타임스탬프 포인트**
4. **🛠️ AI(나)에게 적용할 점** (필수): 이 기술/노하우를 Antigravity 시스템과 사용자 워크플로우에 어떻게 즉시 적용할지. 별도 섹션으로 쓸 것.
5. **📎 아카이빙 3대 메타데이터** (볼트에 저장할 때 필수): `1) 원본 출처` `2) 원본 정보 발행일자` `3) 내 보관소 등록일자`

옵시디언(`C:\전일도`)에 저장할 때는 GEMINI.md가 우선이다. 재확인하지 말고 저장하라.
