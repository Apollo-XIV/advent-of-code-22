$lines = Get-Content "inputs/day1.txt"
$new = @(0)
$all = @()

# PART 1 & 2
foreach ($line in $lines) {
    if ($line -ne "") {
        $new[0] += [Int]$line
    } else {
        $all += $new
        $new = @(0)
    }
}

$all = $all | Sort-Object -Descending
Write-Host $all[0..2] ($all[0..2] | ForEach-Object {$sum += $_}) $sum
<#

add every sum to a list
sort list
grab max value(s)

#>