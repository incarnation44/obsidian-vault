import sys
import json
import re
import os
import urllib.request
from youtube_transcript_api import YouTubeTranscriptApi

sys.stdout.reconfigure(encoding='utf-8')

def extract_video_id(url):
    url = url.strip().lstrip('\ufeff')
    m = re.search(r'(?:v=|\/shorts\/|\/live\/|youtu\.be\/)([a-zA-Z0-9_-]{11})', url)
    return m.group(1) if m else url

def get_video_title(url):
    try:
        req = urllib.request.Request(
            f'https://www.youtube.com/oembed?url={url}&format=json',
            headers={'User-Agent': 'Mozilla/5.0'}
        )
        res = urllib.request.urlopen(req, timeout=3)
        d = json.loads(res.read().decode('utf-8'))
        return d.get('title', 'YouTube Video')
    except:
        return 'YouTube Video'

def fetch_instant_transcript(url):
    video_id = extract_video_id(url)
    title = get_video_title(url)
    
    api = YouTubeTranscriptApi()
    transcript_list = api.list(video_id)
    
    def get_valid_transcript(tr_obj):
        try:
            d = tr_obj.fetch()
            text_concat = " ".join([getattr(x, 'text', '') if not isinstance(x, dict) else x.get('text', '') for x in d]).strip()
            if len(text_concat) > 30 and "[NO SPEECH]" not in text_concat:
                return d
        except Exception:
            pass
        return None

    data = None
    # 1. Try finding transcripts in preferred order
    for lang_code in [['ko', 'ko-KR'], ['en']]:
        try:
            tr = transcript_list.find_transcript(lang_code)
            data = get_valid_transcript(tr)
            if data:
                break
        except Exception:
            pass

    # 2. If no valid manual transcript, search all available transcripts (including auto-generated)
    if not data:
        for tr in transcript_list:
            data = get_valid_transcript(tr)
            if data:
                break

    if not data:
        # Fallback to whatever is available
        try:
            data = next(iter(transcript_list)).fetch()
        except Exception:
            data = []
    
    lines = []
    full_text_list = []
    for item in data:
        start = getattr(item, 'start', 0) if not isinstance(item, dict) else item.get('start', 0)
        txt = getattr(item, 'text', '') if not isinstance(item, dict) else item.get('text', '')
        
        m, s = divmod(int(start), 60)
        time_str = f"{m:02d}:{s:02d}"
        clean_txt = str(txt).replace('\n', ' ').strip()
        if clean_txt:
            lines.append(f"[{time_str}] {clean_txt}")
            full_text_list.append(clean_txt)
            
    full_text = " ".join(full_text_list)
    return {
        "title": title,
        "video_id": video_id,
        "full_text": full_text,
        "lines": lines
    }

if __name__ == "__main__":
    # 인자가 없으면 고정된 파일에서 읽음 (IDE 보안 팝업 원천 차단용)
    url = None
    if len(sys.argv) >= 2:
        url = sys.argv[1]
    else:
        url_file = r"C:\Users\ildoc\.gemini\antigravity\scratch\target_yt.txt"
        if os.path.exists(url_file):
            with open(url_file, "r", encoding="utf-8") as f:
                url = f.read().strip()
                
    if not url:
        print("No URL provided.")
        sys.exit(1)
        
    res = fetch_instant_transcript(url)
    out_json = r"C:\Users\ildoc\.gemini\antigravity\scratch\target_transcript.json"
    with open(out_json, "w", encoding="utf-8") as f:
        json.dump(res, f, ensure_ascii=False, indent=2)
    print(f"TITLE: {res['title']}")
    print(f"TEXT_LENGTH: {len(res['full_text'])}")
    print("--- TRANSCRIPT START ---")
    print(res['full_text'][:2000] + "...")
