---
name: youtube-content
description: YouTube transcripts to summaries, chapters, threads. Use when user shares a YouTube URL or asks to summarize a video. Opencode-only skill, does not touch Gemini or Hermes configs.
agent: opencode-only
machine: shared
---

# youtube-content (opencode only)

Scope: `skills_sync/opencode-youtube-content/` only. Separated from existing `youtube-transcribe`. Do not read or write Gemini (`~/.gemini`) or Hermes (`~/.hermes`) configs.

## Usage

1. Fetch transcript first (subtitle-first, no Whisper fallback):
`python skills_sync/opencode-youtube-content/scripts/fetch_transcript.py "YOUTUBE_URL" --text-only --timestamps`
2. Validate output non-empty. If empty, retry without `--language`. Still empty means transcripts disabled - report that and stop.
3. If transcript exceeds ~50K chars, summarize per chunk then merge.
4. Transform to requested format. Default: concise summary. Options: chapters, chapter summaries, thread, quotes.
5. Verify timestamps and coherence before presenting.

## Rules

- Single dependency: `youtube-transcript-api` (`pip install youtube-transcript-api`).
- No video download, no yt-dlp, no OCR, no batch daemon.
- Do not install globally, do not sync to other agents.
