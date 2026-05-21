$Arguments = @{
    FilePath = "/usr/local/bin/pwsh"
    ArgumentList = "-ExecutionPolicy Bypass -NoProfile -File `"$env:SCRIPT_FILE`" $env:SCRIPT_ARGUMENTS"
    NoNewWindow = $true
    Wait = $true
}

function Set-Interval {
    param (
        [Parameter(Mandatory)]
        [string]$Interval,
        [Parameter(Mandatory=$false)]
        [Switch]$CheckError
    )

    if ($CheckError){
        if((-not($Interval.Substring(0, $Interval.Length - 1) -match "^\d+$")) -Or (-not($Interval[-1] -match "[s|m|h|d|w]"))){
            return $true
        } else {
            return $false
        }
    }

    [char]$lastChar = $Interval[-1]
    [Int64]$time = $Interval.Substring(0, $Interval.Length - 1)

    if ($lastChar -Eq "s") {
        return $time
    } elseif ($lastChar -Eq "m") {
        return $time*60
    } elseif ($lastChar -Eq "h") {
        return $time*3600
    } elseif ($lastChar -Eq "d") {
        return $time*86400
    } elseif ($lastChar -Eq "w") {
        return $time*604800
    }
}


 if (Set-Interval -Interval $env:SCHEDULE_INTERVAL -CheckError){
    Write-Host "invalid INTERVAL" -ForegroundColor Red
    exit 1
}

while ($true){
    Start-Process @Arguments
    Write-Host "CONTAINER: Start interval $env:SCHEDULE_INTERVAL" -ForegroundColor Yellow
    Start-Sleep -Seconds (Set-Interval -Interval $env:SCHEDULE_INTERVAL)
}
