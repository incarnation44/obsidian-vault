# 3-PC 머신 식별 스크립트 (desktop, laptop, academy)
$machineId = $env:MACHINE_ID

if ([string]::IsNullOrWhiteSpace($machineId)) {
    $globalJson = "$env:USERPROFILE\.gemini\machine.json"
    if (Test-Path $globalJson) {
        $data = Get-Content $globalJson -Raw | ConvertFrom-Json
        $machineId = $data.machine_id
    }
}

if ([string]::IsNullOrWhiteSpace($machineId)) {
    $hostname = $env:COMPUTERNAME
    if ($hostname -match "ILDO-LAPTOP") {
        $machineId = "laptop"
    } elseif ($hostname -match "HHAIR2K|KH") {
        $machineId = "academy"
    } else {
        $machineId = "desktop"
    }
}

Write-Output $machineId
