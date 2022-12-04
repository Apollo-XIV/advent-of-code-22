$points = @{
    "A" = 1;
    "X" = 1;
    "B" = 2;
    "Y" = 2;
    "C" = 3;
    "Z" = 3;
}

$lines = Get-Content "inputs/day2.txt"
$score = @(0,0)

# PART 1
foreach ($line in $lines) {
    $score[0] += $points[$line.Substring(2,1)]
    Switch (($points[$line.Substring(0,1)] - $points[$line.Substring(2,1)]+3)%3) {
        0 { $score[0] += 3}
        2 { $score[0] += 6}
    }
}

# PART 2
foreach ($line in $lines) {
    Switch ($line.Substring(2,1)) {
        "X" {   $score[1] += 1 + ($points[$line.Substring(0,1)]+1)%3   }
        "Y" {   $score[1] += 3 + $points[$line.Substring(0,1)]         }
        "Z" {   $score[1] += 7 + ($points[$line.Substring(0,1)]%3)     }
    }
}

Write-Host $score

<#

check if human wins
A = X = Rock        = 1
B = Y = Paper       = 2
C = Z = Scissors    = 3

#>
