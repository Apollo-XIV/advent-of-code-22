$lines = Get-Content "inputs/day13.txt"

function parsePair($pair) {
    $first_pair = $pair[0].ToCharArray()
    <#
        seperate into list of lists and items
        return as list of lists
        send to be compared

        find a bracket
        for each proceding [ ignore a ]
        when found an appropriate ] add anything between them to a list
    #>

    $start = $first_pair.IndexOf([char]'[')+1
    Write-Host $start
    $debt = 0
    for($i=$start;$i-lt$first_pair.Length;$i++) {
        $debt
        if (($first_pair[$i]-eq']')-and($debt -eq 0)) {
            $end = $i
            break
        } elseif ($first_pair[$i]-eq']') {
            $debt--
        } elseif ($first_pair[$i]-eq'[') {
            $debt++
        }
    }
    $out = parsePair($set[$start..$end])

}

$pairs = [System.Collections.ArrayList]::new()
for ($i=0; $i -lt $lines.Length; $i += 3) {
    $count = $pairs.Add(@($lines[$i],$lines[$i+1]))
}

foreach($pair in $pairs) {
    Write-Host $pair
}

parsePair($pairs[0])