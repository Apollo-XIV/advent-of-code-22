$moves = Get-Content "inputs/day9.txt"
# tail pointer
# head pointer
# tracker = list of tail positions



$tracker = @{}
$tail = @(0,0)
$head = @(0,0)
$in = [string]$tail[0] + " " + [string]$tail[1]
$tracker.add($in, 0)

$directions = @{
    "U" = @(0,-1)
    "D" = @(0,1)
    "L" = @(1,0)
    "R" = @(-1,0)
}

foreach ($move in $moves) {
    for($i = [Int]$move.Substring(2,($move.Length - 2)); $i -gt 0; $i--) {
        switch ($move.Substring(0,1)) {
            "U" {$head[1] += 1}
            "D" {$head[1] -= 1}
            "L" {$head[0] -= 1}
            "R" {$head[0] += 1}
        }

        if ((([Math]::Abs($head[0] - $tail[0])) -gt 1) -or
            (([Math]::Abs($head[1] - $tail[1])) -gt 1)) {
                $tail[0] = $head[0] + $directions[$move.Substring(0,1)][0]
                $tail[1] = $head[1] + $directions[$move.Substring(0,1)][1]
                Write-Host $tracker.Count
                $in = [string]$tail[0] + " " + [string]$tail[1]
                try {$tracker.add($in, 0)} catch {}
        }

    }

}
Write-Host $tracker.Count
<#

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