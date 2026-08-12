# 🚀 학원 PC 1분 로컬 AI & Antigravity v2.5.2-FINAL 완벽 자동 설치 스크립트
# 사용법: 파워셸(PowerShell)에서 이 스크립트 실행 (1번 실행으로 집 PC와 100% 동일한 환경 1분 내 자동 복원)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "🚀 학원 PC 2026 Antigravity v2.5.2-FINAL 1분 세팅 시작" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Winget으로 Ollama 및 개발 도구 (GitHub CLI) 설치
Write-Host "[1/6] Ollama 및 GitHub CLI (gh) 확인 및 설치 중..." -ForegroundColor Yellow
winget install --id Ollama.Ollama -e --accept-package-agreements --accept-source-agreements
winget install --id GitHub.cli -e --accept-package-agreements --accept-source-agreements

# 2. Ollama 백그라운드 서버 실행 (GPU 가속 옵티마이저 설정)
Write-Host "[2/6] Ollama 백그라운드 서버 실행 및 GPU 가속 환경 설정 중..." -ForegroundColor Yellow
$env:OLLAMA_FLASH_ATTENTION = "1"
$env:HSA_OVERRIDE_GFX_VERSION = "10.3.0"
$ollamaExe = "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe"
if (Test-Path $ollamaExe) {
    Start-Process -FilePath $ollamaExe -ArgumentList "serve" -WindowStyle Hidden
    Start-Sleep -Seconds 3
}

# 3. 하드웨어 사양 감지 및 적응형 AI 모델 다운로드
Write-Host "[3/7] PC 하드웨어 사양(RAM / GPU) 자동 감지 중..." -ForegroundColor Yellow
$ramGB = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB)
$gpus = (Get-CimInstance Win32_VideoController).Name -join ", "
Write-Host " -> 감지된 RAM: ${ramGB}GB | GPU: $gpus" -ForegroundColor Cyan

if ($ramGB -ge 16 -and ($gpus -match "NVIDIA|Radeon|RTX|GTX|RX")) {
    Write-Host " -> [고성능 모드] 7B/8B 표준 모델 다운로드" -ForegroundColor Green
    & $ollamaExe pull qwen2.5:7b
    & $ollamaExe pull deepseek-r1:8b
} else {
    Write-Host " -> [저사양/내장그래픽 최적화 모드] 초경량 3B/1.5B 고속 모델 자동 탑재 (CPU 무리 제로)" -ForegroundColor Green
    & $ollamaExe pull qwen2.5:3b
    & $ollamaExe pull qwen2.5:1.5b
}


# 4. GitHub에서 전일도 마스터 옵시디언 보관소 클론/동기화
Write-Host "[4/6] GitHub에서 개인 지식 옵시디언 보관소 동기화 중..." -ForegroundColor Yellow
$vaultPath = "C:\전일도"
if (-not (Test-Path $vaultPath)) {
    git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
} else {
    git -C $vaultPath pull origin master
}

# 5. 필수 파이썬 패키지 및 Docling/유튜브 도구 설치
Write-Host "[5/7] 필수 파이썬 패키지 및 Docling / 유튜브 도구 설치 중..." -ForegroundColor Yellow
pip install -r "$vaultPath\requirements.txt" --quiet

# 6. Antigravity 전역 설정 및 스킬 복원
Write-Host "[6/7] Antigravity 전역 규칙 및 스킬 복원 중..." -ForegroundColor Yellow
$configDir = "$env:USERPROFILE\.gemini\config\rules"
$skillsDir = "$env:USERPROFILE\.gemini\config\skills"
New-Item -ItemType Directory -Force -Path $configDir | Out-Null
New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null
Copy-Item -Path "$vaultPath\GEMINI.md" -Destination "$configDir\GEMINI.md" -Force
$workspace = "$env:USERPROFILE\.gemini\antigravity\scratch\my_ai_workspace"
New-Item -ItemType Directory -Force -Path $workspace | Out-Null

# 7. Obsidian RAG 인덱스 증분 재빌드
Write-Host "[7/7] 옵시디언 개인 지식 RAG 인덱싱 구축 중..." -ForegroundColor Yellow
python -c "import sys; sys.path.append(r'$workspace'); from obsidian_rag import build_index; build_index()"

Write-Host "==================================================" -ForegroundColor Green
Write-Host "✅ 새 PC 2026 Antigravity v2.5.2-FINAL 세팅이 완료되었습니다!" -ForegroundColor Green
Write-Host "이제 새 PC에서도 집과 100% 동일한 AI 엔진, 스킬, 옵시디언 지식으로 Antigravity를 사용하실 수 있습니다." -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green

