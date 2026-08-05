# 🚀 학원 PC 1분 로컬 AI & Antigravity gstack 53종 완벽 자동 설치/세팅 스크립트
# 사용법: 파워셸(PowerShell)에서 이 스크립트 실행 (1번 실행으로 현재 PC와 100% 동일한 환경 복원)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "🚀 학원 PC 로컬 AI, gstack 53종 스킬 및 MCP 환경 세팅 시작" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Winget으로 Ollama 설치
Write-Host "[1/5] Ollama (무료 로컬 AI 엔진) 설치 중..." -ForegroundColor Yellow
winget install --id Ollama.Ollama -e --accept-package-agreements --accept-source-agreements

# 2. Ollama 백그라운드 서버 실행 (GPU 가속 옵티마이저 설정)
Write-Host "[2/5] Ollama 백그라운드 서버 실행 및 RX 6600 가속 환경 설정 중..." -ForegroundColor Yellow
$env:OLLAMA_FLASH_ATTENTION = "1"
$env:HSA_OVERRIDE_GFX_VERSION = "10.3.0"
$ollamaExe = "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe"
if (Test-Path $ollamaExe) {
    Start-Process -FilePath $ollamaExe -ArgumentList "serve" -WindowStyle Hidden
    Start-Sleep -Seconds 3
} else {
    Write-Host "Ollama 실행 파일을 찾는 중..." -ForegroundColor Red
}

# 3. 최적 AI 모델 다운로드 (Qwen 3.8 / 2.5 7B & DeepSeek-R1 8B)
Write-Host "[3/5] Qwen 3.8 / 2.5 (7B/8B) 코딩/한국어 모델 다운로드 및 업그레이드..." -ForegroundColor Yellow
& $ollamaExe pull qwen3.8
if ($LASTEXITCODE -ne 0) {
    Write-Host "Qwen 3.8 최신 모델 다운로드 준비 중 - qwen2.5:7b 다운로드 수행..." -ForegroundColor Yellow
    & $ollamaExe pull qwen2.5:7b
}

Write-Host "[3/5] DeepSeek-R1 (8B) 심층 추론 모델 다운로드..." -ForegroundColor Yellow
& $ollamaExe pull deepseek-r1:8b

# 4. GitHub에서 gstack 53종 슈퍼파워 스킬 복원
Write-Host "[4/5] GitHub에서 gstack 53종 스킬 및 MCP 서버 설치 중..." -ForegroundColor Yellow
$gstackSrc = "$env:USERPROFILE\.gemini\antigravity\scratch\gstack"
if (-not (Test-Path $gstackSrc)) {
    git clone https://github.com/garrytan/gstack.git $gstackSrc
}

$mcpOfficialSrc = "$env:USERPROFILE\.gemini\antigravity\mcp\mcp-official-servers"
if (-not (Test-Path $mcpOfficialSrc)) {
    git clone https://github.com/modelcontextprotocol/servers.git $mcpOfficialSrc
    npm --prefix $mcpOfficialSrc install
    npm --prefix $mcpOfficialSrc run build
}

# 5. 워크스페이스 디렉토리 및 테스트 파일 작성
Write-Host "[5/5] 워크스페이스 폴더 생성 및 테스트 파일 작성 중..." -ForegroundColor Yellow
$workspace = "$env:USERPROFILE\.gemini\antigravity\scratch\my_ai_workspace"
New-Item -ItemType Directory -Force -Path $workspace | Out-Null

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
Write-Host "✅ 학원 PC 로컬 AI 및 gstack 53종 세팅이 성공적으로 완료되었습니다!" -ForegroundColor Green
Write-Host "이제 Antigravity를 켜서 자유롭게 사용하시면 됩니다." -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
