function numerify($letter) {
    if (([byte][char]$letter -ge 65) -and ([byte][char]$letter -le 90)) {
        return([byte][char]$letter - 38)
    } elseif (([byte][char]$letter -ge 97) -and ([byte][char]$letter -le 122)) {
        return([byte][char]$letter - 96)
    }
    return 0
}

function fndCmn($backpack) {
    foreach ($item in $backpack.ToCharArray(0,$($backpack.Length/2))) {
        foreach($item2 in $backpack.ToCharArray($backpack.Length/2,$backpack.Length/2)) {
            if ([byte][char]$item -eq [byte][char]$item2) {
                return $item
            }
        }
    }
}

function fndCmn3($bkpks) {
    foreach ($item in $bkpks[0]) {
        foreach($item2 in $bkpks[1]) {
            if ([byte][char]$item -eq [byte][char]$item2) {
                foreach($item3 in $bkpks[2]) {
                    if ([byte][char]$item -eq [byte][char]$item3) {
                        return $item
                    }
                }
            }
        }
    }
}

$lines = Get-Content "inputs/day3.txt"
$total = @(0,0)

# PART 1
foreach ($line in $lines) {
    $out = fndCmn($line)
    $total[0] += (numerify($out))

}

# PART 2
for ($i = 0; $i -lt $lines.Length;$i += 3) {
    $bkpks = @($lines[$i].ToCharArray(0,$lines[$i].Length),$lines[$i+1].ToCharArray(0,$lines[$i+1].Length),$lines[$i+2].ToCharArray(0,$lines[$i+2].Length))
    $out = (fndCmn3($bkpks))
    $total[1] += (numerify($out))
}

Write-Host $total