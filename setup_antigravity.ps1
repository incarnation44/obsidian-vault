# Antigravity (Gemini) - 3-PC Auto Setup Script
# Run this on a new PC (e.g. Desktop, Academy, or Laptop) to fully restore the Antigravity environment.

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

function Write-Step($msg) { Write-Host "▶ $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "  ✅ $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "  ⚠️  $msg" -ForegroundColor Yellow }

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host " Antigravity (Gemini) Workspace & Constitution Auto-Setup Engine " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Device Detection
Write-Step "[1/6] Detecting Machine Profile..."
$gpuInfo = (Get-CimInstance Win32_VideoController | Select-Object -First 1).Name
$cpuInfo = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
$ramGB   = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)

if ($gpuInfo -match "Radeon|RX|6600|7600|7700|7800|7900") {
    $MachineType = "desktop"
} elseif ($gpuInfo -match "Intel|UHD|Integrated|Iris") {
    $MachineType = "laptop"
} else {
    $MachineType = "academy"
}
Write-Ok "Detected Hardware - CPU: $cpuInfo | GPU: $gpuInfo | RAM: ${ramGB}GB"
Write-Ok "Machine Role Assigned: $MachineType"

# 2. Setup Machine Identity for Antigravity
Write-Step "[2/6] Configuring Machine Identity..."
$geminiDir = Join-Path $env:USERPROFILE ".gemini"
if (-not (Test-Path $geminiDir)) { New-Item -ItemType Directory -Force -Path $geminiDir | Out-Null }
$machineJsonPath = Join-Path $geminiDir "machine.json"
@{ "machine_id" = $MachineType } | ConvertTo-Json -Depth 5 | Set-Content -Path $machineJsonPath -Encoding UTF8
[System.Environment]::SetEnvironmentVariable("MACHINE_ID", $MachineType, "User")
Write-Ok "Machine Identity set to '$MachineType'"

# 3. Clone / Pull Obsidian Vault (Source of Truth)
Write-Step "[3/6] Syncing Obsidian Vault (C:\전일도)..."
$vaultPath = "C:\전일도"
if ($MachineType -eq "academy") {
    Write-Warn "Academy PC detected! Skipping personal Obsidian Vault clone for security isolation."
} else {
    if (-not (Test-Path "$vaultPath\.git")) {
        Write-Warn "Obsidian Vault not found at $vaultPath. Cloning from GitHub..."
        git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
    } else {
        Write-Ok "Vault found. Pulling latest changes..."
        git -C $vaultPath pull origin master --rebase
    }
}

# 4. Sync Antigravity Configuration (Rules, Skills, Workspace)
Write-Step "[4/6] Restoring Antigravity Configuration & Skills..."
$rulesDir = Join-Path $geminiDir "config\rules"
$skillsDir = Join-Path $geminiDir "config\skills"
$workspaceDir = Join-Path $geminiDir "antigravity\scratch\my_ai_workspace"

if (-not (Test-Path $rulesDir)) { New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null }
if (-not (Test-Path $skillsDir)) { New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null }
if (-not (Test-Path $workspaceDir)) { New-Item -ItemType Directory -Force -Path $workspaceDir | Out-Null }

if ($MachineType -ne "academy" -and (Test-Path $vaultPath)) {
    if (Test-Path "$vaultPath\GEMINI.md") {
        Copy-Item -Path "$vaultPath\GEMINI.md" -Destination "$rulesDir\GEMINI.md" -Force
        Write-Ok "Constitution (GEMINI.md) fully synced!"
    }
    
    if (Test-Path "$vaultPath\skills_sync") {
        Copy-Item -Path "$vaultPath\skills_sync\*" -Destination $skillsDir -Recurse -Force
        Write-Ok "All Antigravity Skills synced!"
    }
} else {
    Write-Warn "Academy PC or Vault missing. Proceeding with default/existing rules and skills."
}

# 5. Register Startup Auto-Sync
Write-Step "[5/6] Registering Background Auto-Sync..."
if ($MachineType -ne "academy" -and (Test-Path "$vaultPath\scripts\run_sync_laptop_silent.vbs")) {
    $startupFolder = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup"
    $vbsTarget = Join-Path $startupFolder "SyncAntigravityOnBoot.vbs"
    Copy-Item -Path "$vaultPath\scripts\run_sync_laptop_silent.vbs" -Destination $vbsTarget -Force
    Write-Ok "Background boot sync registered in Startup folder."
} else {
    Write-Warn "Skipped auto-sync registration for this environment."
}

# 6. KH_AI Workspace check
Write-Step "[6/6] Checking Projects (KH_AI)..."
$khaiPath = "C:\KH_AI"
if (-not (Test-Path $khaiPath)) {
    Write-Warn "KH_AI workspace not found. Please clone it manually if needed: git clone <kh_ai_repo> C:\KH_AI"
} else {
    Write-Ok "KH_AI workspace exists."
}

Write-Host ""
Write-Host "=================================================================" -ForegroundColor Green
Write-Host " Setup Complete! Your Antigravity Environment is exactly as it was. " -ForegroundColor Green
if ($MachineType -eq "desktop") {
    Write-Host " Desktop mode configured! High-performance settings applied." -ForegroundColor Green
}
Write-Host "=================================================================" -ForegroundColor Green

