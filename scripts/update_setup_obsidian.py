import os
import json
from pathlib import Path

ps1_content = r"""# Dell Latitude 7440 (Intel i5-1345U / 32GB RAM / Iris Xe) Antigravity & Obsidian Setup
param (
    [switch]$SkipOllama
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = 'Dell Latitude 7440 Antigravity & Obsidian Setup'

Write-Host '=================================================================' -ForegroundColor Cyan
Write-Host 'Dell Latitude 7440 Antigravity 2.0 & Obsidian Vault Setup' -ForegroundColor Cyan
Write-Host '   - C:\전일도 Obsidian Vault 자동 등록 및 바로가기 생성' -ForegroundColor Gray
Write-Host '   - Main Desktop (ILDO) Remote Connection' -ForegroundColor Gray
Write-Host '=================================================================' -ForegroundColor Cyan
Write-Host ''

$desktopDir = [System.Environment]::GetFolderPath('Desktop')
$wscript = New-Object -ComObject WScript.Shell

# Step 1: Detect hardware
Write-Host '[1/7] Checking hardware and environment...' -ForegroundColor Yellow
$compModel = (Get-CimInstance Win32_ComputerSystem).Model
$cpuName = (Get-CimInstance Win32_Processor).Name
$ramGB = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB)
Write-Host "  -> Model: $compModel | CPU: $cpuName | RAM: ${ramGB}GB" -ForegroundColor Green

# Step 2: Winget tools (Git, GitHub CLI, VS Code, Obsidian)
Write-Host '[2/7] Checking development & knowledge tools (Git, gh, VS Code, Obsidian)...' -ForegroundColor Yellow
$tools = @(
    @{ Id = 'Git.Git'; Name = 'Git' },
    @{ Id = 'GitHub.cli'; Name = 'GitHub CLI (gh)' },
    @{ Id = 'Microsoft.VisualStudioCode'; Name = 'VS Code' },
    @{ Id = 'Obsidian.Obsidian'; Name = 'Obsidian' }
)

foreach ($tool in $tools) {
    Write-Host "  -> $($tool.Name) checking..." -ForegroundColor Gray
    winget install --id $tool.Id -e --accept-package-agreements --accept-source-agreements --silent 2>$null
}

# Step 3: Sync Obsidian Vault (C:\전일도)
Write-Host '[3/7] Syncing Obsidian Vault (C:\전일도)...' -ForegroundColor Yellow
$vaultPath = 'C:\전일도'
if (-not (Test-Path $vaultPath)) {
    Write-Host '  -> Cloning repository: https://github.com/incarnation44/obsidian-vault.git' -ForegroundColor Cyan
    git clone https://github.com/incarnation44/obsidian-vault.git $vaultPath
} else {
    Write-Host '  -> Pulling latest commits...' -ForegroundColor Cyan
    git -C $vaultPath pull origin master
}

# Step 4: Register C:\전일도 as default Vault in Obsidian App
Write-Host '[4/7] Registering C:\전일도 in Obsidian configuration...' -ForegroundColor Yellow
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
Write-Host '  -> [OK] C:\전일도 registered in Obsidian App (%APPDATA%\obsidian\obsidian.json)!' -ForegroundColor Green

# Create direct Obsidian Vault launcher shortcut
$obsidianShortcutPath = Join-Path $desktopDir '📝 옵시디언 전일도 보관소.lnk'
$obsidianShortcut = $wscript.CreateShortcut($obsidianShortcutPath)
$obsidianShortcut.TargetPath = "explorer.exe"
$obsidianShortcut.Arguments = "obsidian://open?path=C:%5C%EC%A0%84%EC%9D%BC%EB%8F%84"
$obsidianShortcut.Description = 'Open C:\전일도 in Obsidian App'
$obsidianShortcut.Save()
Write-Host '  -> [OK] Desktop shortcut created: 📝 옵시디언 전일도 보관소.lnk' -ForegroundColor Green

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
        Start-Process -FilePath $ollamaExe -ArgumentList 'serve' -WindowStyle Hidden
        Start-Sleep -Seconds 2
        & $ollamaExe pull qwen2.5:3b
        Write-Host '  -> [OK] Low-power AI ready!' -ForegroundColor Green
    }
} else {
    Write-Host '[6/7] Ollama setup skipped.' -ForegroundColor Gray
}

# Step 7: VS Code Extension & Desktop Clean Shortcuts
Write-Host '[7/7] Registering VS Code Extension & Shortcuts...' -ForegroundColor Yellow
$codeExe = (Get-Command code -ErrorAction SilentlyContinue).Source
if ($codeExe) {
    & code --install-extension google.antigravity 2>$null
}

# Clean old invalid PWA shortcut if exists
$oldPwa = Join-Path $desktopDir 'Antigravity Remote Hub (ILDO-Desktop).lnk'
if (Test-Path $oldPwa) {
    # Point it to Antigravity native app
    $antigravityExe = "$env:LOCALAPPDATA\Programs\Antigravity\Antigravity.exe"
    $antigravityIde = "$env:LOCALAPPDATA\Programs\Antigravity IDE\Antigravity.exe"
    if (Test-Path $antigravityExe) {
        $pwaShortcut = $wscript.CreateShortcut($oldPwa)
        $pwaShortcut.TargetPath = $antigravityExe
        $pwaShortcut.Save()
    } elseif (Test-Path $antigravityIde) {
        $pwaShortcut = $wscript.CreateShortcut($oldPwa)
        $pwaShortcut.TargetPath = $antigravityIde
        $pwaShortcut.Save()
    }
}

Write-Host ''
Write-Host '=================================================================' -ForegroundColor Green
Write-Host '🎉 Dell Latitude 7440 Antigravity & Obsidian Setup 100% Complete!' -ForegroundColor Green
Write-Host '=================================================================' -ForegroundColor Green
Write-Host '1. 바탕화면의 [📝 옵시디언 전일도 보관소]를 누르면 C:\전일도 가 자동으로 열립니다.' -ForegroundColor Cyan
Write-Host '2. 바탕화면의 [Antigravity] 네이티브 앱을 실행하시면 원격 연결됩니다.' -ForegroundColor Cyan
Write-Host '=================================================================' -ForegroundColor Green
"""

# Save .ps1 with UTF-8 BOM
with open(r'C:\전일도\setup_dell7440_laptop.ps1', 'w', encoding='utf-8-sig') as f:
    f.write(ps1_content)

bat_content = """@echo off
chcp 65001 > nul
title Dell Latitude 7440 Antigravity & Obsidian Setup
echo =================================================================
echo  Dell Latitude 7440 Antigravity 2.0 & Obsidian Vault Setup
echo =================================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup_dell7440_laptop.ps1"

echo.
pause
"""

with open(r'C:\전일도\setup_dell7440_laptop.bat', 'w', encoding='utf-8') as f:
    f.write(bat_content)

print("Updated setup scripts for Obsidian & Native Antigravity successfully!")
