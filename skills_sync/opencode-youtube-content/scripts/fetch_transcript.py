"""Opencode-only YouTube transcript fetcher (subtitle-first)."""
import argparse
import json
import re
import sys


def extract_id(url_or_id: str) -> str:
    s = url_or_id.strip()
    if re.fullmatch(r"[A-Za-z0-9_-]{11}", s):
        return s
    m = re.search(r"(?:v=|youtu\.be/|/live/|/embed/|/shorts/)([A-Za-z0-9_-]{11})", s)
    if m:
        return m.group(1)
    return s


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("url", help="YouTube URL or 11-char video ID")
    ap.add_argument("--text-only", action="store_true")
    ap.add_argument("--timestamps", action="store_true")
    ap.add_argument("--language", default=None, help="e.g. ko,en")
    args = ap.parse_args()

    try:
        from youtube_transcript_api import YouTubeTranscriptApi
    except ImportError:
        print("missing dependency: pip install youtube-transcript-api", file=sys.stderr)
        return 2

    vid = extract_id(args.url)
    langs = args.language.split(",") if args.language else None
    api = YouTubeTranscriptApi()
    try:
        fetched = api.fetch(vid, languages=langs) if langs else api.fetch(vid)
    except Exception:
        try:
            fetched = api.fetch(vid)
        except Exception as e:
            print(f"fetch failed: {e}", file=sys.stderr)
            return 1

    segs = list(fetched)
    if not segs:
        print("empty transcript (disabled or unavailable)", file=sys.stderr)
        return 1

    if args.text_only:
        if args.timestamps:
            for s in segs:
                print(f"[{s.start:.2f}] {s.text}")
        else:
            print(" ".join(s.text for s in segs))
    else:
        print(json.dumps({
            "video_id": vid,
            "total_segments": len(segs),
            "segments": [{"start": s.start, "duration": s.duration, "text": s.text} for s in segs],
        }, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
