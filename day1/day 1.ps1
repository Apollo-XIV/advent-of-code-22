$inpData = Get-Content "day1\PZLinput.txt"
$max = 0
$2max = 0
$3max = 0
$total = 0
Foreach ($line in $inpData) {
    if ($line -ne "") {
        $total += [Int]$line
    }
    else {
        if ($total -ge $max) {
            $3max = $2max
            $2max = $max
            $max = $total
        } elseif ($total -ge $2max) {
            $3max = $2max
            $2max = $total
        } elseif ($total -ge $3max) {
            $3max = $total
        }
        $total = 0
    }
}
# works fine
$part2 = $max + $2max + $3max
Write-Host $("Day 1!`nPart 1: {0}`nPart 2: {1}" -f [String]$max, [String]$part2)