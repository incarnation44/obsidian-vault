import os
import sys
import argparse
import subprocess
import json
import re
from pathlib import Path

sys.stdout.reconfigure(encoding='utf-8')
os.environ["HF_HUB_DISABLE_SYMLINKS_WARNING"] = "1"

def extract_video_id(url):
    m = re.search(r'(?:v=|\/shorts\/|youtu\.be\/)([a-zA-Z0-9_-]{11})', url)
    if m:
        return m.group(1)
    return "video"

def get_video_title(url):
    try:
        import urllib.request
        res = urllib.request.urlopen(f'https://www.youtube.com/oembed?url={url}&format=json')
        d = json.loads(res.read().decode('utf-8'))
        return d.get('title', 'Unknown Title')
    except:
        return 'YouTube Video'

def try_fast_transcript(video_id):
    try:
        from youtube_transcript_api import YouTubeTranscriptApi
        api = YouTubeTranscriptApi()
        
        # Try fetching Korean or English transcripts
        try:
            transcript_list = api.list(video_id)
            # prefer ko, then en, then first available
            t = None
            try:
                t = transcript_list.find_transcript(['ko', 'ko-KR'])
            except:
                try:
                    t = transcript_list.find_transcript(['en'])
                except:
                    t = next(iter(transcript_list))
            data = t.fetch()
        except:
            data = api.get_transcript(video_id, languages=['ko', 'ko-KR', 'en'])
            
        results = []
        full_text = []
        for item in data:
            start = int(item.get('start', 0))
            m, s = divmod(start, 60)
            time_str = f"{m:02d}:{s:02d}"
            txt = item.get('text', '').strip()
            if txt:
                results.append((time_str, txt))
                full_text.append(txt)
        if full_text:
            return results, " ".join(full_text)
    except Exception as e:
        pass
    return None, None

def download_audio_fallback(url, output_dir, video_id):
    os.makedirs(output_dir, exist_ok=True)
    out_tmpl = os.path.join(output_dir, f"{video_id}.%(ext)s")
    
    # Use android client args to bypass 403 Forbidden
    cmd = [
        'yt-dlp',
        '-x',
        '--audio-format', 'm4a',
        '--no-playlist',
        '--extractor-args', 'youtube:player_client=android,web',
        '--user-agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        '--output', out_tmpl,
        url
    ]
    
    res = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8', errors='ignore')
    
    # Check for downloaded file
    audio_path = os.path.join(output_dir, f"{video_id}.m4a")
    if not os.path.exists(audio_path):
        # check any extension
        files = list(Path(output_dir).glob(f"{video_id}.*"))
        if files:
            audio_path = str(files[0])
        else:
            raise RuntimeError(f"yt-dlp download failed: {res.stderr}")
            
    return audio_path

def transcribe_whisper(audio_path, model_size="base", language=None):
    from faster_whisper import WhisperModel
    import huggingface_hub
    
    models_dir = os.path.join(os.path.expanduser("~"), ".cache", "whisper_models", model_size)
    os.makedirs(models_dir, exist_ok=True)
    
    repo_id = f"Systran/faster-whisper-{model_size}"
    model_path = huggingface_hub.snapshot_download(
        repo_id=repo_id,
        local_dir=models_dir,
        local_dir_use_symlinks=False
    )
    
    model = WhisperModel(model_path, device="cpu", compute_type="int8")
    segments, info = model.transcribe(audio_path, beam_size=5, language=language)
    
    results = []
    full_text = []
    for segment in segments:
        m, s = divmod(int(segment.start), 60)
        time_str = f"{m:02d}:{s:02d}"
        text = segment.text.strip()
        results.append((time_str, text))
        full_text.append(text)
        
    return results, " ".join(full_text)

def run(url, model_size="base", output_dir=None, language=None):
    if not output_dir:
        output_dir = os.path.join(os.path.expanduser("~"), ".gemini", "antigravity", "scratch", "transcripts")
    os.makedirs(output_dir, exist_ok=True)
    
    video_id = extract_video_id(url)
    title = get_video_title(url)
    print(f"🎬 Video: {title} ({video_id})")
    
    # 1. Fast Path
    print("[1/2] Checking official captions...")
    segments, full_text = try_fast_transcript(video_id)
    
    # 2. Whisper Fallback
    if not full_text:
        print("[2/2] No captions found. Downloading audio & running Faster-Whisper...")
        audio_path = download_audio_fallback(url, output_dir, video_id)
        segments, full_text = transcribe_whisper(audio_path, model_size=model_size, language=language)
        if os.path.exists(audio_path):
            os.remove(audio_path)
    else:
        print("✅ Captions retrieved via Fast-Path!")
        
    # Save transcript markdown
    md_path = os.path.join(output_dir, f"{video_id}_transcript.md")
    with open(md_path, "w", encoding="utf-8") as f:
        f.write(f"# 🎙️ YouTube Transcript: {title}\n\n")
        f.write(f"- **URL**: {url}\n")
        f.write(f"- **Video ID**: `{video_id}`\n\n")
        f.write("## 📝 Full Text\n\n")
        f.write(full_text + "\n\n")
        f.write("## ⏱️ Timestamps\n\n")
        for t, txt in segments:
            f.write(f"- **[{t}]** {txt}\n")
            
    return md_path, title, full_text

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("url", nargs="?", default=None, help="YouTube URL")
    parser.add_argument("--model", default="base")
    parser.add_argument("--outdir", default=None)
    parser.add_argument("--lang", default=None)
    args = parser.parse_args()
    
    url = args.url
    if not url:
        url_file = r"C:\Users\ildoc\.gemini\antigravity\scratch\target_yt.txt"
        if os.path.exists(url_file):
            with open(url_file, "r", encoding="utf-8") as f:
                url = f.read().strip()
                
    if not url:
        print("No URL provided.")
        sys.exit(1)
        
    md_path, title, full_text = run(url, args.model, args.outdir, args.lang)
    print(f"Transcript saved to: {md_path}")
    print(f"Full length: {len(full_text)} characters")
