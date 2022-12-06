function Read-Input($lines) {
    $stacks = @()
    for ($i = 0; $i -lt $lines[0].Length/4; $i++) {
        $stacks += @("")
    }
    
    for ($lIdx = 0; -Not ($lines[$lIdx] -match '\d'); $lIdx++) {
        for (($i = 1), ($j=0); $i -lt $lines[$lIdx].Length-1; ($i+=4), ($j++)) {
            $stacks[$j] = $lines[$lIdx][$i] + $stacks[$j]
            $stacks[$j] = $stacks[$j] -replace "\s+" , ''
        }
    }
    return $stacks
}

function Read-Move($line) {
    $moves = $($($($lines[$i] -replace "[^0-9]" , ' ') -replace '\s+', ' ') -replace '^\s+', '') -split ' '
    return $moves
}

function Move-9000($x, $a, $b) {
    for ($i = 0; $i -lt $x; $i++) {
        $b += $($a.Substring($a.Length-1,1))
        $a = $a.Substring(0,$a.Length-1)
    }
    return @($a, $b)
}

function Move-9001($x, $a, $b) {
    return @(($a.Substring(0, $a.Length - $x)), ($b + $a.Substring($a.Length - $x, $x)))
}

$lines = Get-Content "inputs/day5.txt"
$stacks = Read-Input $lines

for ($i = 10; $i -lt $lines.Length; $i++) {
    $moves = Read-Move($lines[$i])
    $out = Move-9000 -x $([Int]$moves[0]) -a $($stacks[[Int]$moves[1]-1]) -b $($stacks[[Int]$moves[2]-1])
    $stacks[$moves[1]-1] = $out[0]
    $stacks[$moves[2]-1] = $out[1]
}

Write-Host "Part 1:"
foreach ($stack in $stacks) {Write-Host $stack}

$stacks = Read-Input $lines

for ($i = 10; $i -lt $lines.Length; $i++) {
    $moves = Read-Move($lines[$i])
    $out = Move-9001 -x $([Int]$moves[0]) -a $($stacks[[Int]$moves[1]-1]) -b $($stacks[[Int]$moves[2]-1])
    $stacks[$moves[1]-1] = $out[0]
    $stacks[$moves[2]-1] = $out[1]
}

Write-Host "`nPart 2:"
foreach ($stack in $stacks) {Write-Host $stack}