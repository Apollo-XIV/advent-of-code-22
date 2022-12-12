$moves = Get-Content "inputs/day9.txt"
# tail pointer
# head pointer
# tracker = list of tail positions



$tracker = @{}
$rope = @(@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0),@(0,0))
$in = [string]$rope[$rope.Length-1][0] + " " + [string]$rope[$rope.Length-1][1]
$tracker.add($in, 0)

foreach ($move in $moves) {
    for($i = [Int]$move.Substring(2,($move.Length - 2)); $i -gt 0; $i--) {
        switch ($move.Substring(0,1)) {
            "U" {$rope[0][1] += 1}
            "D" {$rope[0][1] -= 1}
            "L" {$rope[0][0] -= 1}
            "R" {$rope[0][0] += 1}
        }

        for ($j=1; $j -lt $rope.Length; $j++){
            Write-Host "Cur. Knot:" $rope[$j] " Prev. Knot:" $rope[$j-1]
            <#
            
            if a and b
            if not a
            if not b
            else

            alt:
            - if x.difference -gt 1 move x closer
            - if y.difference -gt 1 move x closer
            
            #>
            $x = if (([Math]::Abs($rope[$j-1][0] - $rope[$j][0])) -gt 1) {$true} else {$false}
            $y = if (([Math]::Abs($rope[$j-1][1] - $rope[$j][1])) -gt 1) {$true} else {$false}
            if ($x -and $y) {
                $rope[$j][0] = [Int]($rope[$j][0] + $rope[$j-1][0])/2
                $rope[$j][1] = [Int]($rope[$j][1] + $rope[$j-1][1])/2
            } elseif ($x) {
                $rope[$j][0] = [Int]($rope[$j][0] + $rope[$j-1][0])/2
                $rope[$j][1] = $rope[$j-1][1]
            } elseif ($y) {
                $rope[$j][1] = [Int]($rope[$j][1] + $rope[$j-1][1])/2
                $rope[$j][0] = $rope[$j-1][0]
            }
            
        }

        $in = [string]$rope[$rope.Length-1][0] + " " + [string]$rope[$rope.Length-1][1]
        Write-Host "add" $in
        if (-not $tracker.ContainsKey($in)) {$tracker.add($in,0)}
    }

}

Write-Host $rope
$tracker
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


..............
..012.........
.....3........
.....4........
.....5........
.....6........
.....7........
.....8........






#>