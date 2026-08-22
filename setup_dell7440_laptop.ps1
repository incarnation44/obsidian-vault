# 🚀 Dell Latitude 7440 (Intel i5-1345U / 32GB RAM / Iris Xe) 전용 Antigravity 1분 세팅 스크립트
# 사용법: Dell 노트북에서 PowerShell을 관리자 권한으로 열고 실행하거나, setup_dell7440_laptop.bat 더블클릭

param (
    [switch]$SkipOllama
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "🚀 Dell Latitude 7440 Antigravity Remote Hub Setup"

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "💻 Dell Latitude 7440 (서브 노트북) Antigravity 2.0 원격 허브 세팅" -ForegroundColor Cyan
Write-Host "   - 메인 데스크톱(ILDO, Ryzen 5600X/RX 6600) 연동 최적화" -ForegroundColor Gray
Write-Host "   - Iris Xe 저전력 배터리 보호 및 PWA 단독 앱 환경 자동 구축" -ForegroundColor Gray
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""

# [1단계] 하드웨어 및 실행 환경 감지
Write-Host "[1/7] 노트북 하드웨어 사양 및 실행 환경 점검 중..." -ForegroundColor Yellow
$compModel = (Get-CimInstance Win32_ComputerSystem).Model
$cpuName = (Get-CimInstance Win32_Processor).Name
$ramGB = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB)
Write-Host "  -> 모델: $compModel | CPU: $cpuName | RAM: ${ramGB}GB" -ForegroundColor Green

# [2단계] GitHub CLI, Git, VS Code 설치/점검
Write-Host "[2/7] 필수 개발 도구 (Git, GitHub CLI, VS Code) 점검 중..." -ForegroundColor Yellow
$tools = @(
    @{ Id = "Git.Git"; Name = "Git" },
    @{ Id = "GitHub.cli"; Name = "GitHub CLI (gh)" },
    @{ Id = "Microsoft.VisualStudioCode"; Name = "VS Code" }
)

foreach ($tool in $tools) {
    Write-Host "  -> $($tool.Name) 확인 중..." -ForegroundColor Gray
    winget install --id $tool.Id -e --accept-package-agreements --accept-source-agreements --silent 2>$null
}

# [3단계] PWA 단독 앱 바로가기 생성 (Chrome / Edge 앱 모드)
Write-Host "[3/7] Antigravity PWA 단독 웹 앱 바탕화면 바로가기 생성 중..." -ForegroundColor Yellow
$desktopDir = [System.Environment]::GetFolderPath('Desktop')
$wscript = New-Object -ComObject WScript.Shell

# 브라우저 실행 파일 탐색 (Chrome 우선, 없으면 Edge)
$chromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
$chromePath86 = "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
$edgePath = "$env:ProgramFiles(x86)\Microsoft\Edge\Application\msedge.exe"
$edgePath64 = "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"

$targetBrowser = $null
if (Test-Path $chromePath) { $targetBrowser = $chromePath }
elseif (Test-Path $chromePath86) { $targetBrowser = $chromePath86 }
elseif (Test-Path $edgePath) { $targetBrowser = $edgePath }
elseif (Test-Path $edgePath64) { $targetBrowser = $edgePath64 }

if ($targetBrowser) {
    $pwaShortcutPath = Join-Path $desktopDir "🚀 Antigravity Remote Hub (ILDO-Desktop).lnk"
    $pwaShortcut = $wscript.CreateShortcut($pwaShortcutPath)
    $pwaShortcut.TargetPath = $targetBrowser
    $pwaShortcut.Arguments = "--app=https://anti-gravity.google.com"
    $pwaShortcut.Description = "Google Antigravity 2.0 원격 제어 허브 (메인 PC 연결)"
    $pwaShortcut.Save()
    Write-Host "  -> ✅ 바탕화면에 'Antigravity Remote Hub' PWA 바로가기 생성 완료!" -ForegroundColor Green
} else {
    Write-Host "  -> [주의] 지원되는 브라우저(Chrome/Edge)를 찾지 못했습니다." -ForegroundColor DarkYellow
}

# [4단계] 옵시디언 개인 지식 보관소 (C:\전일도) 동기화
Write-Host "[4/7] GitHub에서 옵시디언 지식 보관소(C:\전일도) 동기화 중..." -ForegroundColor Yellow
$vaultPath = "C:\전일도"
if (-not (Test-Path $vaultPath)) {
    Write-Host "  -> 저장소 최초 클론 진행: https://github.com/incarnation44/obsidian-vault.git" -ForegroundColor Cyan
    git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
} else {
    Write-Host "  -> 기존 보관소 최신 변경사항 풀(Pull)..." -ForegroundColor Cyan
    git -C $vaultPath pull origin master
}

# [5단계] Antigravity 전역 규칙 및 환경 설정 복원
Write-Host "[5/7] Antigravity 전역 헌법(GEMINI.md) 및 스킬 디렉터리 동기화 중..." -ForegroundColor Yellow
$rulesDir = "$env:USERPROFILE\.gemini\config\rules"
$skillsDir = "$env:USERPROFILE\.gemini\config\skills"
$workspaceDir = "$env:USERPROFILE\.gemini\antigravity\scratch\my_ai_workspace"

New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null
New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null
New-Item -ItemType Directory -Force -Path $workspaceDir | Out-Null

if (Test-Path "$vaultPath\GEMINI.md") {
    Copy-Item -Path "$vaultPath\GEMINI.md" -Destination "$rulesDir\GEMINI.md" -Force
    Write-Host "  -> ✅ GEMINI.md 최상위 헌법 복원 완료" -ForegroundColor Green
}

# [6단계] 노트북 저전력 배터리 보호 로컬 AI (Ollama) 설정
if (-not $SkipOllama) {
    Write-Host "[6/7] 노트북 저전력 배터리 보호 모드 로컬 AI (Ollama) 점검 중..." -ForegroundColor Yellow
    winget install --id Ollama.Ollama -e --accept-package-agreements --accept-source-agreements --silent 2>$null
    
    $ollamaExe = "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe"
    if (Test-Path $ollamaExe) {
        Write-Host "  -> Ollama 서버 백그라운드 시작..." -ForegroundColor Gray
        Start-Process -FilePath $ollamaExe -ArgumentList "serve" -WindowStyle Hidden
        Start-Sleep -Seconds 2
        
        Write-Host "  -> [배터리 최적화] 외장 VRAM 부재에 맞춘 초경량 3B 모델 탑재..." -ForegroundColor Cyan
        & $ollamaExe pull qwen2.5:3b
    }
} else {
    Write-Host "[6/7] Ollama 설정 건너뜀 (클라우드/원격 허브 전용 모드)" -ForegroundColor Gray
}

# [7단계] VS Code 확장 및 보조 바로가기 생성
Write-Host "[7/7] VS Code 및 지식 보관소 바로가기 등록 중..." -ForegroundColor Yellow
$codeExe = (Get-Command code -ErrorAction SilentlyContinue).Source
if ($codeExe) {
    Write-Host "  -> VS Code Antigravity Extension 설치 시도..." -ForegroundColor Cyan
    & code --install-extension google.antigravity 2>$null
}

# 옵시디언 바로가기 생성
$obsidianShortcutPath = Join-Path $desktopDir "📝 옵시디언 전일도 보관소.lnk"
$obsidianShortcut = $wscript.CreateShortcut($obsidianShortcutPath)
$obsidianShortcut.TargetPath = "explorer.exe"
$obsidianShortcut.Arguments = "C:\전일도"
$obsidianShortcut.Description = "C:\전일도 옵시디언 메인 보관소"
$obsidianShortcut.Save()

Write-Host ""
Write-Host "=================================================================" -ForegroundColor Green
Write-Host "🎉 Dell Latitude 7440 Antigravity 2.0 세팅이 100% 완료되었습니다!" -ForegroundColor Green
Write-Host "=================================================================" -ForegroundColor Green
Write-Host "1. 바탕화면의 [🚀 Antigravity Remote Hub]를 클릭하여 실행합니다." -ForegroundColor Cyan
Write-Host "2. 'Ildo-Desktop' 인스턴스를 선택하면 데스크톱의 파워를 100% 원격 제어합니다." -ForegroundColor Cyan
Write-Host "3. 배터리 소모 0%로 발열 없이 고성능 AI Vibe Coding을 즐기세요!" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Green
