$forest = Get-Content "inputs/day8.txt"
$total = 0
$score = 0

foreach($sect in $forest) {
    $sect = $sect.ToCharArray()
    foreach($tree in $sect) {
        $tree = [Int]$tree
    }
}

function searchX($forest, $r, $c) {
    $score = 1
    $fail = 0
    $slice = @($forest | ForEach-Object {$_[$c]})
    # search north
    $north = $slice[($r - 1)..0]
    # search east
    $east = $forest[$r][($c + 1)..$forest[$r].Length]
    # search south
    $south = $slice[($r + 1)..$slice.Length]
    # search west
    $west = $forest[$r][($c - 1)..0]

    $cardinals = @($north, $east, $south, $west)

    foreach($dir in $cardinals) {
        $vDis = 0
        foreach($tree in $dir) {
            $vDis += 1
            if ($tree -ge $forest[$r][$c]) {
                $fail += 1
                break
            }

            
        }
        $score = $score * $vDis
    }
    if ($fail -ne 4) {
        return @($true, $score)
    } else {
        return @($false, $score)
    }

}

for($r=1; $r -lt ($forest.Length - 1); $r++) {
    for($c=1 ; $c -lt ($forest[$r].Length - 1); $c++) {
        $out = searchX -forest $forest -r $r -c $c
        if ($out[0]) {$total += 1}
        if ($out[1] -gt $score) {$score = $out[1]}
    }
}

$total += $forest.Length*2 + $forest[0].Length*2 - 4

Write-Host $total $score