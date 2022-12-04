$points = @{
    "A" = 1;
    "X" = 1;
    "B" = 2;
    "Y" = 2;
    "C" = 3;
    "Z" = 3;
}

$lines = Get-Content "day2\input.txt"
$human = 0

foreach ($line in $lines) {
    $human += $points[$line.Substring(2,1)]
    Switch (($points[$line.Substring(0,1)] - $points[$line.Substring(2,1)]+3)%3) {
        0 { $human += 3}
        2 { $human += 6}
    }
}
$human

<#

check if human wins
A = X = Rock        = 1
B = Y = Paper       = 2
C = Z = Scissors    = 3

#>
