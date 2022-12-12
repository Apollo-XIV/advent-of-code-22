$moves = Get-Content "inputs/day9test.txt"
# tail pointer
# head pointer
# tracker = list of tail positions



$tracker = @{}
$rope = @(@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0))
$in = [string]$rope[9][0] + " " + [string]$rope[9][1]
$tracker.add($in, 0)

foreach ($move in $moves) {
    for($i = [Int]$move.Substring(2,($move.Length - 2)); $i -gt 0; $i--) {
        switch ($move.Substring(0,1)) {
            "U" {$rope[0][1] += 1}
            "D" {$rope[0][1] -= 1}
            "L" {$rope[0][0] -= 1}
            "R" {$rope[0][0] += 1}
        }

        for ($j=1; $j -lt 10; $j++){
            if (([Math]::Abs($rope[$j-1][0] - $rope[$j][0])) -gt 1) {
                $rope[$j][0] = $rope[$j][0] + ($rope[$j-1][0] - $rope[$j][0])
                $rope[$j][1] = $rope[$j-1][1]
            }
            if (([Math]::Abs($rope[$j-1][1] - $rope[$j][1])) -gt 1) {
                $rope[$j][1] = $rope[$j][1] + ($rope[$j-1][1] - $rope[$j][1])
                $rope[$j][0] = $rope[$j-1][0]
            }
        }
        Write-Host $tracker.Count
        $in = [string]$rope[9][0] + " " + [string]$rope[9][1]
        if (-not $tracker.ContainsKey($in)) {$tracker.add($in,0)}
    }

}
Write-Host $rope
Write-Host $tracker.Count
<#

.....
.....
...H.
.....


alternatively, track wherever the tail goes, add to array, calc final score

......
......
......
..H...
......

......
......
..H...
..T...
......

......
..H...
..T..
..S...
......

..H...
..T...
......
..S...
......



#>