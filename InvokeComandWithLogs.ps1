$computers = Get-Content 'computers.txt'

$results = foreach ($computer in $computers) {
    Write-Host "Working on $computer..."
    try {
        $output = Invoke-Command -ComputerName $computer -ScriptBlock {             
            # Do something remotely
        } -ErrorAction Stop
    }
    catch {
        $output = $_.Exception.Message
    }

    if ($output) {
        $result = $output 
    }
    else {
        $result = 'Success' 
    }

    [pscustomobject]@{
        ComputerName = $computer
        Output       = $result
    }
}

# Export results to csv file
$date = Get-Date -Format yyyy-MM-dd_HH-mm
$results | Export-Csv -Path "Logs_$date.csv" -NoTypeInformation