# 🚀 학원 PC 1분 로컬 AI & 에이전트 자동 설치/세팅 스크립트
# 사용법: 파워셸(PowerShell)에서 이 파일 실행

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "🚀 학원 PC 로컬 AI 및 Antigravity 워크스페이스 세팅 시작" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Winget으로 Ollama 설치
Write-Host "[1/4] Ollama (무료 로컬 AI 엔진) 설치 중..." -ForegroundColor Yellow
winget install --id Ollama.Ollama -e --accept-package-agreements --accept-source-agreements

# 2. Ollama 백그라운드 서버 실행
Write-Host "[2/4] Ollama 백그라운드 서버 실행 중..." -ForegroundColor Yellow
$ollamaExe = "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe"
if (Test-Path $ollamaExe) {
    Start-Process -FilePath $ollamaExe -ArgumentList "serve" -WindowStyle Hidden
    Start-Sleep -Seconds 3
} else {
    Write-Host "Ollama 실행 파일을 찾는 중..." -ForegroundColor Red
}

# 3. 최적 AI 모델 다운로드 (Qwen 2.5 7B & DeepSeek-R1 8B)
Write-Host "[3/4] Qwen 2.5 (7B) 초고속 모델 다운로드..." -ForegroundColor Yellow
& $ollamaExe pull qwen2.5:7b

Write-Host "[3/4] DeepSeek-R1 (8B) 심층 추론 모델 다운로드..." -ForegroundColor Yellow
& $ollamaExe pull deepseek-r1:8b

# 4. 워크스페이스 디렉토리 및 테스트 파일 작성
Write-Host "[4/4] 워크스페이스 폴더 생성 및 연동 파일 복사 중..." -ForegroundColor Yellow
$workspace = "$env:USERPROFILE\.gemini\antigravity\scratch\my_ai_workspace"
New-Item -ItemType Directory -Force -Path $workspace | Out-Null

# 테스트 파이썬 파일 작성
$pyTestContent = @"
import sys
import io
import urllib.request
import json
import time

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def test_ollama(model_name="qwen2.5:7b", prompt="안녕하세요! 학원 PC 세팅 완료 테스트입니다."):
    url = "http://localhost:11434/api/generate"
    data = {"model": model_name, "prompt": prompt, "stream": False}
    headers = {'Content-Type': 'application/json'}
    
    start_time = time.time()
    req = urllib.request.Request(url, data=json.dumps(data).encode('utf-8'), headers=headers)
    try:
        with urllib.request.urlopen(req) as response:
            res_json = json.loads(response.read().decode('utf-8'))
            elapsed = time.time() - start_time
            response_text = res_json.get("response", "")
            tps = res_json.get("eval_count", 0) / (res_json.get("eval_duration", 1) / 1e9)
            print(f"[{model_name}] 응답: {response_text}")
            print(f"속도: {tps:.2f} tokens/sec (소요시간: {elapsed:.2f}초)")
    except Exception as e:
        print(f"에러: {e}")

if __name__ == "__main__":
    test_ollama()
"@

Set-Content -Path "$workspace\test_local_ai.py" -Value $pyTestContent -Encoding UTF8

Write-Host "==================================================" -ForegroundColor Green
Write-Host "✅ 학원 PC 로컬 AI 세팅이 성공적으로 완료되었습니다!" -ForegroundColor Green
Write-Host "이제 Antigravity를 켜서 자유롭게 사용하시면 됩니다." -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
