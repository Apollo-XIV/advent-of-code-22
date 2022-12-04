$lines = Get-Content "day1/PZLinput.txt"
$new = @(0)
$all = @()

foreach ($line in $lines) {
    if ($line -ne "") {
        $new[0] += [Int]$line
    } else {
        $all += $new
        $new = @(0)
    }
}

$all = $all | Sort-Object -Descending
Write-Host $all[0] $all[1] $all[2]

<#

add every sum to a list
sort list
grab max value(s)

#>