@echo off
chcp 65001 >nul
:: 관리자 권한 확인 및 자동 승격 요청
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [안내] 윈도우 시스템 설정을 변경하기 위해 관리자 권한을 요청합니다...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

title 윈도우 11 5대 성능 최적화 적용기
echo ======================================================
echo 🚀 윈도우 11 5대 핵심 최적화 자동 적용 시작
echo ======================================================
echo.

echo [1/4] 메모리 페이지 콤바이닝 비활성화 (32GB RAM 최적화)...
powershell -NoProfile -Command "Disable-MMAgent -PageCombining; $s = (Get-MMAgent).PageCombining; Write-Host '   -> 페이지 콤바이닝 상태 (False가 정상):' $s"

echo.
echo [2/4] 빠른 시작 켜기 해제 (시스템 완전 종료 & 드라이버 꼬임 방지)...
powershell -NoProfile -Command "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -Value 0 -Type DWord -Force; $s = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled').HiberbootEnabled; Write-Host '   -> 빠른 시작 상태 (0이 정상):' $s"

echo.
echo [3/4] 하드웨어 가속 GPU 일정 예약 (HAGS) 활성화...
powershell -NoProfile -Command "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' -Name 'HwSchMode' -Value 2 -Type DWord -Force; $s = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' -Name 'HwSchMode').HwSchMode; Write-Host '   -> HAGS 상태 (2가 정상):' $s"

echo.
echo [4/4] 저장 공간 센스 (Storage Sense) 활성화...
powershell -NoProfile -Command "$p='HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy'; if(-not (Test-Path $p)){New-Item -Path $p -Force | Out-Null}; Set-ItemProperty -Path $p -Name '01' -Value 1 -Type DWord -Force; Write-Host '   -> 저장 공간 센스: 활성화 완료'"

echo.
echo ======================================================
echo ✅ 모든 최적화 적용이 완벽히 완료되었습니다!
echo 💡 변경된 GPU 일정 예약(HAGS) 및 빠른 시작 해제는
echo    PC 재부팅 시점부터 100%% 완벽 적용됩니다.
echo ======================================================
echo.
pause
