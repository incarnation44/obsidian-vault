# Dell Latitude 7440 (Intel i5-1345U / 32GB RAM / Iris Xe) Antigravity & Obsidian Setup
param (
    [switch]$SkipOllama
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = 'Dell Latitude 7440 Antigravity & Obsidian Setup'

Write-Host '=================================================================' -ForegroundColor Cyan
Write-Host 'Dell Latitude 7440 Antigravity & Obsidian Clean Setup' -ForegroundColor Cyan
Write-Host '=================================================================' -ForegroundColor Cyan
Write-Host ''

# 1. Clean up unnecessary desktop shortcuts created earlier
Write-Host '[1/6] Cleaning up temporary desktop shortcuts...' -ForegroundColor Yellow
$desktopPaths = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\OneDrive\Desktop",
    "$env:USERPROFILE\OneDrive\바탕 화면",
    "$env:USERPROFILE\OneDrive\바탕화면"
)

$unwantedFiles = @(
    "Antigravity Remote Hub (ILDO-Desktop).lnk",
    "🚀 Antigravity Remote Hub (ILDO-Desktop).lnk",
    "Obsidian Vault.lnk",
    "📝 옵시디언 전일도 보관소.lnk",
    "setup_dell7440_laptop.bat",
    "setup_dell7440_laptop.ps1"
)

foreach ($dp in $desktopPaths) {
    if (Test-Path $dp) {
        foreach ($uf in $unwantedFiles) {
            $target = Join-Path $dp $uf
            if (Test-Path $target) {
                Remove-Item -Path $target -Force -ErrorAction SilentlyContinue
                Write-Host "  -> Removed: $uf" -ForegroundColor Gray
            }
        }
    }
}

# 2. Sync Obsidian Vault (C:\전일도)
Write-Host '[2/6] Syncing Obsidian Vault (C:\전일도)...' -ForegroundColor Yellow
$vaultPath = 'C:\전일도'
if (-not (Test-Path $vaultPath)) {
    git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
} else {
    git -C $vaultPath pull origin master --rebase
}

# 3. Register C:\전일도 in Obsidian App
Write-Host '[3/6] Registering C:\전일도 in Obsidian App configuration...' -ForegroundColor Yellow
$obsidianConfigDir = Join-Path $env:APPDATA 'obsidian'
if (-not (Test-Path $obsidianConfigDir)) {
    New-Item -ItemType Directory -Force -Path $obsidianConfigDir | Out-Null
}

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
Write-Host '  -> [OK] C:\전일도 registered in Obsidian App!' -ForegroundColor Green

# 4. Sync GEMINI.md Constitution
Write-Host '[4/6] Syncing GEMINI.md Constitution...' -ForegroundColor Yellow
$rulesDir = Join-Path $env:USERPROFILE '.gemini\config\rules'
$skillsDir = Join-Path $env:USERPROFILE '.gemini\config\skills'
$workspaceDir = Join-Path $env:USERPROFILE '.gemini\antigravity\scratch\my_ai_workspace'

if (-not (Test-Path $rulesDir)) { New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null }
if (-not (Test-Path $skillsDir)) { New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null }
if (-not (Test-Path $workspaceDir)) { New-Item -ItemType Directory -Force -Path $workspaceDir | Out-Null }

if (Test-Path (Join-Path $vaultPath 'GEMINI.md')) {
    Copy-Item -Path (Join-Path $vaultPath 'GEMINI.md') -Destination (Join-Path $rulesDir 'GEMINI.md') -Force
    Write-Host '  -> [OK] GEMINI.md Constitution synced!' -ForegroundColor Green
}

# 5. Register Automatic Boot/Logon Sync Engine (Always Keep Identical State)
Write-Host '[5/6] Registering Automatic Startup Auto-Sync Engine...' -ForegroundColor Yellow
$startupFolder = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup'
$vbsSource = Join-Path $vaultPath 'scripts\run_sync_laptop_silent.vbs'
$vbsTarget = Join-Path $startupFolder 'SyncLaptopOnBoot.vbs'

if (Test-Path $vbsSource) {
    Copy-Item -Path $vbsSource -Destination $vbsTarget -Force
    Write-Host '  -> [OK] Startup folder auto-sync registered!' -ForegroundColor Green
}

# Also register Task Scheduler for robust logon trigger
try {
    $action = New-ScheduledTaskAction -Execute "wscript.exe" -Argument "`"C:\전일도\scripts\run_sync_laptop_silent.vbs`""
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Minutes 5)
    Register-ScheduledTask -TaskName "AutoSyncLaptopOnLogon" -Action $action -Trigger $trigger -Settings $settings -Force -ErrorAction SilentlyContinue | Out-Null
    Write-Host '  -> [OK] Task Scheduler AutoSyncLaptopOnLogon registered!' -ForegroundColor Green
} catch {
    Write-Host '  -> [INFO] Task Scheduler registration skipped (User privilege maintained).' -ForegroundColor Gray
}

# 6. Low-power Ollama AI (if needed)
if (-not $SkipOllama) {
    Write-Host '[6/6] Checking low-power Ollama AI...' -ForegroundColor Yellow
    $ollamaExe = Join-Path $env:LOCALAPPDATA 'Programs\Ollama\ollama.exe'
    if (Test-Path $ollamaExe) {
        Start-Process -FilePath $ollamaExe -ArgumentList 'serve' -WindowStyle Hidden
    }
}

Write-Host ''
Write-Host '=================================================================' -ForegroundColor Green
Write-Host 'Setup & Auto-Sync Engine complete!' -ForegroundColor Green
Write-Host 'Laptop will now automatically sync with Desktop on every boot.' -ForegroundColor Green
Write-Host '=================================================================' -ForegroundColor Green
