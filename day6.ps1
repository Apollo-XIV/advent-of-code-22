$line = (Get-Content ".\inputs\day6.txt").ToCharArray()
function find-Mult($num, $line){
    for ($i=$num-1; $i -lt $line.Length; $i++) {
        $score = 0
        foreach ($letter in ($line[($i - $num + 1)..$i])) {
            if ($($line[($i - $num + 1)..$i] -split $letter).Length -eq ($num + 1)) {
                $score += 1
            }
        }
        if ($score -eq $num) {
            return ($i+1)
        }
    }
}
Write-Host (find-Mult -num 4 -line $line)
Write-Host (find-Mult -num 14 -line $line)