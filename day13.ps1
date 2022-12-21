$lines = Get-Content "inputs/day13.txt"

function parsePair($set) {
    <#
        seperate into list of lists and items
        return as list of lists
        send to be compared

        find a bracket
        for each proceding [ ignore a ]
        when found an appropriate ] add anything between them to a list
    #>
    if ($set.Indexof('[')-eq-1) {
        return $set
    }
    $start = $set.IndexOf([char]'[')+1
    Write-Host $start
    
    $debt = 0
    for($i=$start;$i-lt$set.Length;$i++) {
        $debt
        if (($set[$i]-eq']')-and($debt -eq 0)) {
            $end = $i
            break
        } elseif ($set[$i]-eq']') {
            $debt--
        } elseif ($set[$i]-eq'[') {
            $debt++
        }
    }
    $out = parsePair($set[$start..$end])
    return $out
}

$pairs = [System.Collections.ArrayList]::new()
for ($i=0; $i -lt $lines.Length; $i += 3) {
    $count = $pairs.Add(@($lines[$i],$lines[$i+1]))
}

foreach($pair in $pairs) {
    Write-Host $pair
}

Write-Host parsePair($pairs[0].ToCharArray())