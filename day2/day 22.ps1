$lines = Get-Content "day2/input.txt"
$points = @{
    "A" = 1
    "B" = 2
    "C" = 3
}

$score = 0
foreach ($line in $lines) {
    Switch ($line.Substring(2,1)) {
        "X" {   $score += 1 + ($points[$line.Substring(0,1)]+1)%3   }
        "Y" {   $score += 3 + $points[$line.Substring(0,1)]         }
        "Z" {   $score += 7 + ($points[$line.Substring(0,1)]%3)     }
    }
}
$score

<#
    playing rock gives you 1 point
    playing paper gives you 2 points
    playing scissors gives you 3 points

    therefore

    to win,
    1->2
    2->3
    3->1
    xmod3+1

    to lose, 
    1->3
    2->1
    3->2
    (x+1)mod3+1
#>