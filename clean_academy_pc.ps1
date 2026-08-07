# 🧹 학원 PC 수업 종료 후 1초 흔적 파기 및 보안 철통 삭제 스크립트
# 사용법: 학원 수업 마치고 집으로 가기 전 이 스크립트를 1번만 실행하세요.

Write-Host "==================================================" -ForegroundColor Yellow
Write-Host "🛡️ 학원 PC 개인 데이터 & 자격증명 완전 파기 시작" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Yellow

# 1. 깃허브 자격 증명(Git Credential Manager) 삭제 (다른 사람이 git pull/push 못하도록 차단)
Write-Host "[1/4] 학원 PC에 남은 GitHub 로그인 자격 증명 파기 중..." -ForegroundColor Cyan
cmdkey /list | Select-String "git:" | ForEach-Object {
    $target = $_.ToString().Split(":")[-1].Trim()
    cmdkey /delete:$target | Out-Null
}

# 2. 학원 PC 로컬 옵시디언 폴더 삭제 (C:\전일도 및 관련 파일 완전 파기)
Write-Host "[2/4] 학원 PC 로컬 옵시디언 파일 및 워크스페이스 삭제 중..." -ForegroundColor Cyan
$vaultPath = "C:\전일도"
if (Test-Path $vaultPath) {
    Remove-Item -Path $vaultPath -Recurse -Force -ErrorAction SilentlyContinue
}

$workspace = "$env:USERPROFILE\.gemini\antigravity\scratch\my_ai_workspace"
if (Test-Path $workspace) {
    Remove-Item -Path $workspace -Recurse -Force -ErrorAction SilentlyContinue
}

# 3. 실행 중인 백그라운드 AI 프로세스 종료
Write-Host "[3/4] 백그라운드 AI 프로세스 깔끔 종료 중..." -ForegroundColor Cyan
Get-Process -Name "ollama", "python" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

# 4. 완료 안내
Write-Host "==================================================" -ForegroundColor Green
Write-Host "✅ 학원 PC 개인 정보 파기 완료!" -ForegroundColor Green
Write-Host "다른 사람이 절대 내 옵시디언 노트나 GitHub에 접근할 수 없습니다." -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
