<#
A, X = Rock = 1
B, Y = Paper = 2
C, Z = Scissors = 3

Y > A > Z > B > X > C
Y >   > Z >   > X >  
  > A >   > B >   > C
2 > 1 > 3 > 2 > 1 > 3

Paper - Rock = 1
Rock - Scissors = -2
Scissors - Paper = 1

Rock - Paper = -1
Scissors - Rock = 2
Paper - Scissors = -1

-1 or 2 is a win for the human
1 or -2 is a win for the elf
0 is a tie


-2 + 3 = 1
-1 + 3 = 2

1 + 3  = 4
2 + 3  = 5

4mod3 = 

#>


$points = @{
    "A" = 1;
    "X" = 1;
    "B" = 2;
    "Y" = 2;
    "C" = 3;
    "Z" = 3;
}

$lines = Get-Content "day2\input.txt"
$elf = 0
$human = 0

foreach ($line in $lines) {
    $elf += $points[$line.Substring(0,1)]
    $human += $points[$line.Substring(2,1)]
    Switch (($points[$line.Substring(0,1)] - $points[$line.Substring(2,1)]+3)%3) {
        0 {
            $elf += 3
            $human += 3
        }
        1 { $elf += 6}
        2 { $human += 6}
    }
}
$human