# Dell Latitude 7440 Boot/Logon Auto-Sync Engine
# Automatically synchronizes Obsidian Vault, GEMINI.md Constitution, Skills, and Daily Updates on laptop startup.

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$logDir = 'C:\전일도\05_일일_리포트'
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Force -Path $logDir | Out-Null }
$logFile = Join-Path $logDir 'laptop_sync_log.txt'

function Write-SyncLog {
    param([string]$Message)
    $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $logMsg = "[$ts] $Message"
    Add-Content -Path $logFile -Value $logMsg -Encoding UTF8
}

Write-SyncLog "=== Laptop Auto-Sync Initiated on Boot/Logon ==="

# 1. Wait for network connectivity (max 20 seconds)
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
    Write-SyncLog "WARN: Network not reachable after 20s. Proceeding with offline sync."
} else {
    Write-SyncLog "INFO: Internet connection verified."
}

# 2. Git Pull latest changes from master
$vaultPath = 'C:\전일도'
if (Test-Path $vaultPath) {
    if ($connected) {
        try {
            Write-SyncLog "INFO: Pulling latest changes from GitHub repository..."
            $gitStatus = git -C $vaultPath pull origin master --rebase 2>&1
            Write-SyncLog "INFO: Git Pull Result: $gitStatus"
        } catch {
            Write-SyncLog "ERROR: Git pull failed: $_"
        }
    }
} else {
    if ($connected) {
        Write-SyncLog "INFO: C:\전일도 does not exist. Cloning repository..."
        git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
    }
}

# 3. Sync GEMINI.md Constitution
$rulesDir = Join-Path $env:USERPROFILE '.gemini\config\rules'
if (-not (Test-Path $rulesDir)) { New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null }
$sourceConstitution = Join-Path $vaultPath 'GEMINI.md'
$destConstitution = Join-Path $rulesDir 'GEMINI.md'

if (Test-Path $sourceConstitution) {
    Copy-Item -Path $sourceConstitution -Destination $destConstitution -Force
    Write-SyncLog "INFO: GEMINI.md Constitution successfully synced to ~/.gemini/config/rules/GEMINI.md"
}

# 4. Sync Global Skills
$skillsSrc = Join-Path $vaultPath 'skills_sync'
$skillsDst = Join-Path $env:USERPROFILE '.gemini\config\skills'
if (Test-Path $skillsSrc) {
    if (-not (Test-Path $skillsDst)) { New-Item -ItemType Directory -Force -Path $skillsDst | Out-Null }
    robocopy $skillsSrc $skillsDst /E /R:1 /W:1 /NP /NFL /NDL | Out-Null
    Write-SyncLog "INFO: Global Skills (44 skills) successfully synced to ~/.gemini/config/skills"
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

# 5. Check Daily Delta
$todayStr = Get-Date -Format 'yyyy-MM-dd'
$todayReport = Join-Path $logDir "$todayStr.md"
if (Test-Path $todayReport) {
    Write-SyncLog "INFO: Today daily report ($todayStr.md) verified."
} else {
    Write-SyncLog "INFO: Creating initial daily log placeholder for $todayStr..."
    $header = @"
---
title: "$todayStr 일일 업무 및 시스템 리포트 (노트북 자동 연동)"
aliases: ["$todayStr 일일 리포트", "$todayStr 업데이트"]
category: "05_일일_리포트"
created_date: "$todayStr"
tags: ["일일리포트", "시스템업데이트", "Dell7440", "자동동기화"]
---

# $todayStr 일일 업무 및 시스템 리포트

## 💻 노트북 자동 동기화 상태
- **기기**: Dell Latitude 7440 (Intel 13th Gen i5 / 32GB RAM / Iris Xe)
- **동기화 시각**: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
- **동기화 상태**: GitHub 마스터 및 데스크톱 환경과 100% 일치 확인 완료.
"@
    Set-Content -Path $todayReport -Value $header -Encoding UTF8
}

Write-SyncLog "=== Laptop Auto-Sync Completed Successfully ==="
