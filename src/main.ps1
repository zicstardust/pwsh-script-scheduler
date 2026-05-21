$Arguments = @{
    FilePath = "/usr/bin/pwsh"
    ArgumentList = "-ExecutionPolicy Bypass -NoProfile -File `"$env:SCRIPT_FILE`" $env:SCRIPT_ARGUMENTS"
    NoNewWindow = $true
    Wait = $true
}


while ($true){



    Start-Process @Arguments

    Start-Sleep $SCHEDULE_INTERVAL

}