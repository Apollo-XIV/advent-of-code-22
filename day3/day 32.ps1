function fndCmn($bkpks) {
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
function numerify($letter) {
    if (([byte][char]$letter -ge 65) -and ([byte][char]$letter -le 90)) {
        return([byte][char]$letter - 38)
    } elseif (([byte][char]$letter -ge 97) -and ([byte][char]$letter -le 122)) {
        return([byte][char]$letter - 96)
    }
    return 0
}

$lines = Get-Content "day3/input.txt"
$total = 0

for ($i = 0; $i -lt $lines.Length;$i += 3) {
    $bkpks = @($lines[$i].ToCharArray(0,$lines[$i].Length),$lines[$i+1].ToCharArray(0,$lines[$i+1].Length),$lines[$i+2].ToCharArray(0,$lines[$i+2].Length))
    $out = (fndCmn($bkpks))
    $total += (numerify($out))
}
Write-Host $total