import os
from pathlib import Path

# setup_dell7440_laptop.ps1 content (UTF-8 with BOM)
ps1_content = r"""# Dell Latitude 7440 (Intel i5-1345U / 32GB RAM / Iris Xe) Antigravity Remote Hub Setup
param (
    [switch]$SkipOllama
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = 'Dell Latitude 7440 Antigravity Remote Hub Setup'

Write-Host '=================================================================' -ForegroundColor Cyan
Write-Host 'Dell Latitude 7440 Antigravity 2.0 Remote Hub Setup' -ForegroundColor Cyan
Write-Host '   - Main Desktop (ILDO, Ryzen 5600X/RX 6600) Remote Connection' -ForegroundColor Gray
Write-Host '   - Iris Xe Battery Protection and PWA Standalone App' -ForegroundColor Gray
Write-Host '=================================================================' -ForegroundColor Cyan
Write-Host ''

# Step 1: Detect hardware
Write-Host '[1/7] Checking hardware and environment...' -ForegroundColor Yellow
$compModel = (Get-CimInstance Win32_ComputerSystem).Model
$cpuName = (Get-CimInstance Win32_Processor).Name
$ramGB = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB)
Write-Host "  -> Model: $compModel | CPU: $cpuName | RAM: ${ramGB}GB" -ForegroundColor Green

# Step 2: Winget tools
Write-Host '[2/7] Checking development tools (Git, GitHub CLI, VS Code)...' -ForegroundColor Yellow
$tools = @(
    @{ Id = 'Git.Git'; Name = 'Git' },
    @{ Id = 'GitHub.cli'; Name = 'GitHub CLI (gh)' },
    @{ Id = 'Microsoft.VisualStudioCode'; Name = 'VS Code' }
)

foreach ($tool in $tools) {
    Write-Host "  -> $($tool.Name) checking..." -ForegroundColor Gray
    winget install --id $tool.Id -e --accept-package-agreements --accept-source-agreements --silent 2>$null
}

# Step 3: Create PWA shortcut
Write-Host '[3/7] Creating Antigravity PWA Standalone App Shortcut on Desktop...' -ForegroundColor Yellow
$desktopDir = [System.Environment]::GetFolderPath('Desktop')
$wscript = New-Object -ComObject WScript.Shell

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
    $pwaShortcutPath = Join-Path $desktopDir 'Antigravity Remote Hub (ILDO-Desktop).lnk'
    $pwaShortcut = $wscript.CreateShortcut($pwaShortcutPath)
    $pwaShortcut.TargetPath = $targetBrowser
    $pwaShortcut.Arguments = '--app=https://anti-gravity.google.com'
    $pwaShortcut.Description = 'Google Antigravity 2.0 Remote Control Hub'
    $pwaShortcut.Save()
    Write-Host '  -> [OK] Desktop PWA Shortcut created!' -ForegroundColor Green
} else {
    Write-Host '  -> [WARN] Chrome or Edge not found.' -ForegroundColor DarkYellow
}

# Step 4: Sync Obsidian Vault
Write-Host '[4/7] Syncing Obsidian Vault (C:\전일도)...' -ForegroundColor Yellow
$vaultPath = 'C:\전일도'
if (-not (Test-Path $vaultPath)) {
    Write-Host '  -> Cloning repository: https://github.com/incarnation44/obsidian-vault.git' -ForegroundColor Cyan
    git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
} else {
    Write-Host '  -> Pulling latest commits...' -ForegroundColor Cyan
    git -C $vaultPath pull origin master
}

# Step 5: Antigravity rules and workspace
Write-Host '[5/7] Syncing GEMINI.md Constitution & Workspace...' -ForegroundColor Yellow
$rulesDir = Join-Path $env:USERPROFILE '.gemini\config\rules'
$skillsDir = Join-Path $env:USERPROFILE '.gemini\config\skills'
$workspaceDir = Join-Path $env:USERPROFILE '.gemini\antigravity\scratch\my_ai_workspace'

if (-not (Test-Path $rulesDir)) { New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null }
if (-not (Test-Path $skillsDir)) { New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null }
if (-not (Test-Path $workspaceDir)) { New-Item -ItemType Directory -Force -Path $workspaceDir | Out-Null }

if (Test-Path (Join-Path $vaultPath 'GEMINI.md')) {
    Copy-Item -Path (Join-Path $vaultPath 'GEMINI.md') -Destination (Join-Path $rulesDir 'GEMINI.md') -Force
    Write-Host '  -> [OK] GEMINI.md Constitution synced successfully!' -ForegroundColor Green
}

# Step 6: Low power Ollama AI
if (-not $SkipOllama) {
    Write-Host '[6/7] Setting up low-power Ollama AI (3B lightweight)...' -ForegroundColor Yellow
    winget install --id Ollama.Ollama -e --accept-package-agreements --accept-source-agreements --silent 2>$null
    
    $ollamaExe = Join-Path $env:LOCALAPPDATA 'Programs\Ollama\ollama.exe'
    if (Test-Path $ollamaExe) {
        Write-Host '  -> Starting Ollama background daemon...' -ForegroundColor Gray
        Start-Process -FilePath $ollamaExe -ArgumentList 'serve' -WindowStyle Hidden
        Start-Sleep -Seconds 2
        
        Write-Host '  -> Pulling lightweight qwen2.5:3b model for offline emergency use...' -ForegroundColor Cyan
        & $ollamaExe pull qwen2.5:3b
    }
} else {
    Write-Host '[6/7] Ollama setup skipped.' -ForegroundColor Gray
}

# Step 7: VS Code Extension
Write-Host '[7/7] Registering VS Code Extension...' -ForegroundColor Yellow
$codeExe = (Get-Command code -ErrorAction SilentlyContinue).Source
if ($codeExe) {
    Write-Host '  -> Installing VS Code Antigravity Extension...' -ForegroundColor Cyan
    & code --install-extension google.antigravity 2>$null
}

# Obsidian shortcut
$obsidianShortcutPath = Join-Path $desktopDir 'Obsidian Vault.lnk'
$obsidianShortcut = $wscript.CreateShortcut($obsidianShortcutPath)
$obsidianShortcut.TargetPath = 'explorer.exe'
$obsidianShortcut.Arguments = 'C:\전일도'
$obsidianShortcut.Description = 'Obsidian Knowledge Vault'
$obsidianShortcut.Save()

Write-Host ''
Write-Host '=================================================================' -ForegroundColor Green
Write-Host 'Dell Latitude 7440 Antigravity 2.0 Setup 100% Complete!' -ForegroundColor Green
Write-Host '=================================================================' -ForegroundColor Green
Write-Host '1. Click [Antigravity Remote Hub] on your Desktop.' -ForegroundColor Cyan
Write-Host '2. Select [Ildo-Desktop] to control Desktop with 0% laptop battery drain.' -ForegroundColor Cyan
Write-Host '=================================================================' -ForegroundColor Green
"""

# Save .ps1 with UTF-8 BOM
with open(r'C:\전일도\setup_dell7440_laptop.ps1', 'w', encoding='utf-8-sig') as f:
    f.write(ps1_content)

# Save .bat with pure ASCII / UTF-8 without BOM
bat_content = """@echo off
chcp 65001 > nul
title Dell Latitude 7440 Antigravity Remote Setup
echo =================================================================
echo  Dell Latitude 7440 Antigravity 2.0 Remote Hub Setup
echo =================================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup_dell7440_laptop.ps1"

echo.
pause
"""

with open(r'C:\전일도\setup_dell7440_laptop.bat', 'w', encoding='utf-8') as f:
    f.write(bat_content)

print("Updated setup scripts successfully!")
