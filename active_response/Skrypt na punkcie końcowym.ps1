param(
    [string]$ProcessName
)

# Jeśli Wazuh przekaże nazwę procesu – użyj jej, w przeciwnym razie szukaj podejrzanych
if (-not $ProcessName) {
    $suspicious = Get-Process | Where-Object {
        $_.ProcessName -match 'encrypt|crypto|locker|ransom'
    }
} else {
    $suspicious = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
}

foreach ($p in $suspicious) {
    try {
        Stop-Process -Id $p.Id -Force
        Write-Output "Killed suspicious process: $($p.ProcessName) (PID: $($p.Id))"
    } catch {
        Write-Output "Failed to kill process: $($p.ProcessName) (PID: $($p.Id))"
    }
}

# Izolacja hosta – blokada ruchu w Windows Firewall (poza ruchem zarządzającym, jeśli chcę go zostawić)
New-NetFirewallRule -DisplayName "Wazuh_Isolation_Block_All" `
    -Direction Inbound -Action Block -Protocol Any
New-NetFirewallRule -DisplayName "Wazuh_Isolation_Block_All_Out" `
    -Direction Outbound -Action Block -Protocol Any
