function numerify($letter) {
    if (([byte][char]$letter -ge 65) -and ([byte][char]$letter -le 90)) {
        return([byte][char]$letter - 38)
    } elseif (([byte][char]$letter -ge 97) -and ([byte][char]$letter -le 122)) {
        return([byte][char]$letter - 96)
    }
    return 0
}

function fndCmn($backpack) {
    $comp1 = $backpack.ToCharArray(0,$($backpack.Length/2))
    $comp2 = $backpack.ToCharArray($backpack.Length/2,$backpack.Length/2)
    foreach ($item in $comp1) {
        foreach($item2 in $comp2) {
            if ([byte][char]$item -eq [byte][char]$item2) {
                return $item
            }
        }
    }

}

$lines = Get-Content "day3/input.txt"
$total = 0

foreach ($line in $lines) {
    $out = fndCmn($line)
    $total += (numerify($out))

}
$total