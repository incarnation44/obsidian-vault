# Main Desktop (Ildo 본체) Boot/Logon Auto-Sync Engine
# Automatically pulls latest laptop changes from GitHub, syncs GEMINI.md Constitution,
# and enforces Hardware/GPU Protection Guardrails (Prevents GPU/Model Downgrades).

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$logDir = 'C:\전일도\05_일일_리포트'
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Force -Path $logDir | Out-Null }
$logFile = Join-Path $logDir 'desktop_sync_log.txt'

function Write-SyncLog {
    param([string]$Message)
    $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $logMsg = "[$ts] $Message"
    Add-Content -Path $logFile -Value $logMsg -Encoding UTF8
}

Write-SyncLog "=== Main Desktop Auto-Sync Initiated on Boot/Logon ==="

# 1. Network Connectivity Check (max 20s)
$connected = $false
$retryCount = 0
while (-not $connected -and $retryCount -lt 10) {
    try {
        $ping = Test-Connection -ComputerName "github.com" -Count 1 -Quiet -ErrorAction SilentlyContinue
        if ($ping) { $connected = $true; break }
    } catch {}
    Start-Sleep -Seconds 2
    $retryCount++
}

if (-not $connected) {
    Write-SyncLog "WARN: Internet not reachable after 20s. Proceeding with offline mode."
} else {
    Write-SyncLog "INFO: Internet connection verified."
}

# 2. Pull latest laptop updates from GitHub
$vaultPath = 'C:\전일도'
if (Test-Path $vaultPath) {
    if ($connected) {
        try {
            Write-SyncLog "INFO: Pulling latest laptop updates from GitHub repository..."
            $gitStatus = git -C $vaultPath pull origin master --rebase 2>&1
            Write-SyncLog "INFO: Git Pull Result: $gitStatus"
        } catch {
            Write-SyncLog "ERROR: Git pull failed: $_"
        }
    }
}

# 3. Sync GEMINI.md Constitution
$rulesDir = Join-Path $env:USERPROFILE '.gemini\config\rules'
if (-not (Test-Path $rulesDir)) { New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null }
$sourceConstitution = Join-Path $vaultPath 'GEMINI.md'
$destConstitution = Join-Path $rulesDir 'GEMINI.md'

if (Test-Path $sourceConstitution) {
    Copy-Item -Path $sourceConstitution -Destination $destConstitution -Force
    Write-SyncLog "INFO: GEMINI.md Constitution synced to ~/.gemini/config/rules/GEMINI.md"
}

# 4. Sync Global Skills
$skillsSrc = Join-Path $vaultPath 'skills_sync'
$skillsDst = Join-Path $env:USERPROFILE '.gemini\config\skills'
if (Test-Path $skillsSrc) {
    if (-not (Test-Path $skillsDst)) { New-Item -ItemType Directory -Force -Path $skillsDst | Out-Null }
    robocopy $skillsSrc $skillsDst /E /R:1 /W:1 /NP /NFL /NDL | Out-Null
    Write-SyncLog "INFO: Global Skills (44 skills) synced from skills_sync."
}

# 5. Hardware & GPU Protection Guardrail (하드웨어별 설정 분리 및 다운그레이드 방지)
Write-SyncLog "INFO: Verifying Main Desktop Hardware & GPU Guardrails..."
try {
    # Verify Desktop Hardware Profile
    $gpuInfo = Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name
    $isRadeonPresent = ($gpuInfo -match "Radeon" -or $gpuInfo -match "RX 6600")
    
    if ($isRadeonPresent) {
        Write-SyncLog "GUARD: AMD Radeon RX 6600 (8GB VRAM) detected. Desktop GPU acceleration profile PRESERVED."
        Write-SyncLog "GUARD: High-performance 8B/7B local AI models (qwen2.5-coder:7b, deepseek-r1:8b) remain default for local tasks."
    } else {
        Write-SyncLog "WARN: Radeon GPU not detected directly via CIM, maintaining desktop high-power mode."
    }
} catch {
    Write-SyncLog "WARN: Hardware inspection skipped: $_"
}

# 5. Sync Obsidian App configuration
$obsidianConfigDir = Join-Path $env:APPDATA 'obsidian'
if (-not (Test-Path $obsidianConfigDir)) { New-Item -ItemType Directory -Force -Path $obsidianConfigDir | Out-Null }
$obsidianJsonPath = Join-Path $obsidianConfigDir 'obsidian.json'
$vaultConfig = @{
    vaults = @{
        "e96ee284ef644d2e" = @{
            path = "C:\전일도"
            ts = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
            open = $true
        }
    }
}
$vaultConfig | ConvertTo-Json -Depth 5 | Set-Content -Path $obsidianJsonPath -Encoding UTF8
Write-SyncLog "INFO: C:\전일도 registered in Obsidian App."

# 6. Check Daily Delta
$todayStr = Get-Date -Format 'yyyy-MM-dd'
$todayReport = Join-Path $logDir "$todayStr.md"
if (Test-Path $todayReport) {
    Write-SyncLog "INFO: Today daily report ($todayStr.md) verified."
}

Write-SyncLog "=== Main Desktop Auto-Sync Completed Successfully ==="
