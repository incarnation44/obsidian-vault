# =====================================================================
# 🔥 [초자동화 통합 설치기] OpenCode + Hermes + Antigravity All-in-One
# =====================================================================
# 이 스크립트 하나만 실행하면 아무것도 기억할 필요 없이 모든 AI 에이전트가 세팅됩니다.

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

function Write-Step($msg) { Write-Host "
▶ $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "  ✅ $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "  ⚠️  $msg" -ForegroundColor Yellow }

# ---------------------------------------------------------
Write-Step "[1/6] Node.js 및 OpenCode 생태계 자동 설치"
# ---------------------------------------------------------
if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Ok "Node.js가 이미 설치되어 있습니다."
} else {
    Write-Warn "Node.js가 없습니다. Winget을 통해 자동 설치합니다..."
    winget install OpenJS.NodeJS -e --silent
    Write-Warn "Node.js 설치가 완료되었습니다. 스크립트를 껐다가 다시 실행해주세요!"
    exit
}

Write-Host "  - OpenCode 및 oh-my-opencode 설치 중..."
npm install -g opencode oh-my-opencode --force | Out-Null
Write-Ok "OpenCode & oh-my-opencode 에이전트 설치 완료"

# ---------------------------------------------------------
Write-Step "[2/6] 기기 탐지 및 Antigravity 3-PC 프로필 설정"
# ---------------------------------------------------------
$gpuInfo = (Get-CimInstance Win32_VideoController | Select-Object -First 1).Name
if ($gpuInfo -match "Radeon|RX|6600|7600|7700|7800|7900") { $MachineType = "desktop" }
elseif ($gpuInfo -match "Intel|UHD|Integrated|Iris") { $MachineType = "laptop" }
else { $MachineType = "academy" }

$geminiDir = Join-Path $env:USERPROFILE ".gemini"
if (-not (Test-Path $geminiDir)) { New-Item -ItemType Directory -Force -Path $geminiDir | Out-Null }
$machineJsonPath = Join-Path $geminiDir "machine.json"
@{ "machine_id" = $MachineType } | ConvertTo-Json -Depth 5 | Set-Content -Path $machineJsonPath -Encoding UTF8
[System.Environment]::SetEnvironmentVariable("MACHINE_ID", $MachineType, "User")
Write-Ok "현재 기기($MachineType) 프로필 등록 완료"

# ---------------------------------------------------------
Write-Step "[3/6] 옵시디언 볼트 (지식창고) 클론 및 헤르메스 패키지 확인"
# ---------------------------------------------------------
$vaultPath = "C:\전일도"
if ($MachineType -eq "academy") {
    Write-Warn "학원 PC 모드: 개인 볼트 동기화를 생략합니다."
} else {
    if (-not (Test-Path "$vaultPath\.git")) {
        Write-Host "  - 깃허브에서 지식창고(옵시디언) 다운로드 중..."
        git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
    } else {
        git -C $vaultPath pull origin master --rebase | Out-Null
    }
    Write-Ok "볼트 동기화 완료"
}

# ---------------------------------------------------------
Write-Step "[4/6] 헌법, 스킬, 그리고 Hermes 백업본 자동 이식"
# ---------------------------------------------------------
$rulesDir = Join-Path $geminiDir "config\rules"
$skillsDir = Join-Path $geminiDir "config\skills"
$workspaceDir = Join-Path $geminiDir "antigravity\scratch\my_ai_workspace"
foreach ($dir in @($rulesDir, $skillsDir, $workspaceDir)) {
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
}

if ($MachineType -ne "academy" -and (Test-Path $vaultPath)) {
    # 헌법(GEMINI.md) 복사
    Copy-Item -Path "$vaultPath\GEMINI.md" -Destination "$rulesDir\GEMINI.md" -Force
    # 스킬(skills_sync) 복사
    if (Test-Path "$vaultPath\skills_sync") {
        Copy-Item -Path "$vaultPath\skills_sync\*" -Destination $skillsDir -Recurse -Force
    }
    # Hermes 백업 패키지가 있다면 추가 복사
    $hermesPath = "$vaultPath\03_운영\hermes-setup-berber44"
    if (Test-Path $hermesPath) {
        Write-Ok "Hermes 이식 패키지를 발견했습니다. 추가 세팅을 병합합니다."
        # (필요시 Hermes 특정 파일들을 워크스페이스나 스킬로 덮어쓰기)
        if (Test-Path "$hermesPath\skills") {
            Copy-Item -Path "$hermesPath\skills\*" -Destination $skillsDir -Recurse -Force
        }
    }
    Write-Ok "Antigravity & Hermes 설정 100% 이식 완료"
}

# ---------------------------------------------------------
Write-Step "[5/6] 시작프로그램 자동 동기화 엔진 장착"
# ---------------------------------------------------------
if ($MachineType -ne "academy" -and (Test-Path "$vaultPath\scripts\run_sync_$(${MachineType})_silent.vbs")) {
    $startupFolder = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup"
    Copy-Item -Path "$vaultPath\scripts\run_sync_$(${MachineType})_silent.vbs" -Destination "$startupFolder\SyncAntigravityOnBoot.vbs" -Force
    Write-Ok "부팅 시 자동 최신화 엔진 장착 완료"
}

# ---------------------------------------------------------
Write-Step "[6/6] 마지막 단계: API 키 직접 입력 (기억할 필요 없음!)"
# ---------------------------------------------------------
$envPath = Join-Path $workspaceDir ".env"
$apiKey = Read-Host "  🔑 DeepSeek 또는 Gemini API 키를 붙여넣기 해주세요 (이미 세팅되었거나 나중에 하려면 그냥 엔터)"

if (![string]::IsNullOrWhiteSpace($apiKey)) {
    $envContent = "GEMINI_API_KEY=$apiKey
DEEPSEEK_API_KEY=$apiKey"
    $envContent | Set-Content -Path $envPath -Encoding UTF8
    Write-Ok ".env 파일에 API 키 저장 완료!"
} else {
    Write-Warn "API 키 입력을 건너뛰었습니다. 기존 키를 유지합니다."
}

Write-Host "
=================================================================" -ForegroundColor Green
Write-Host " 🚀 축하합니다! 완벽하게 모든 설치와 세팅이 끝났습니다." -ForegroundColor Green
Write-Host " OpenCode, oh-my-opencode, Hermes, Antigravity 모두 출격 준비 완료!" -ForegroundColor Green
Write-Host "=================================================================" -ForegroundColor Green
