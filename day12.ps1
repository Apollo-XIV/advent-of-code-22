class coord {
    [Int]$r
    [Int]$c
    [Int]$value
    [Int]$steps

    coord ($r,$c,$v,$s) {
        $this.r = $r
        $this.c = $c
        $this.value = $v
        $this.steps = $s
    }
}

$lines = Get-Content "inputs/day12.txt"
for ($i=0;$i -lt $lines.Length;$i++) {
    $lines[$i] = $lines[$i].ToCharArray()
}

<#
ALGORITHM
SETUP
$TODO - QUEUE OF POINTS TO VISIT
$DONE - POINTS WHICH HAVE BEEN VISITED

1. POP FROM $TODO
2. SEARCH SURROUNDING 4 POINTS
3. MAKE SURE POINTS NOT IN $DONE
4. IF dHEIGHTS <= 1 ADD TO TODO
5. ADD POINT TO $DONE ALONG WITH HOWEVER MANY STEPS IT TOOK TO GET THERE

#>

$TODO = [System.Collections.Queue]::new()
$DONE = [System.Collections.ArrayList]::new()
for ($r=0;$r -lt $lines.Length;$r++) {
    $DONE.Add([System.Collections.ArrayList]::new())
    for ($c=0;$c -lt $lines[$r].Length;$c++) {
        $DONE[$r].Add("0")
    }
}


for ($r=0;$r -lt $lines.Length;$r++) {
    for ($c=0;$c -lt $lines[$r].Length;$c++) {
        if ($lines[$r][$c] -eq 'S') {
            $pt = [coord]::new($r,$c,[byte][char]'a',0)
            $TODO.enqueue($pt.psobject.Copy())
        }
        if ($lines[$r][$c] -eq 'E') {
            $target = [coord]::new($r,$c,$lines[$r][$c],0)
            $lines[$r][$c] = 'z'
        }
    }
}
while ($true) {
    if ($TODO.Count -eq 0) {
        break
    }
    $pt = $TODO.Dequeue()
    if ($DONE[$pt.r][$pt.c] -ne "0") {
        continue
    }
    $up = if ($pt.r -gt 0) {[coord]::new($pt.r-1,$pt.c,$lines[$pt.r-1][$pt.c],$pt.steps+1)} else {[coord]::new(0,0,[Byte][Char]'Z',0)}
    $down = if ($pt.r -lt $lines.Length-1) {[coord]::new($pt.r+1,$pt.c,$lines[$pt.r+1][$pt.c],$pt.steps+1)} else {[coord]::new(0,0,[Byte][Char]'Z',0)}
    $left = if ($pt.c -gt 0) {[coord]::new($pt.r,$pt.c-1,$lines[$pt.r][$pt.c-1],$pt.steps+1)} else {[coord]::new(0,0,[Byte][Char]'Z',0)}
    $right = if ($pt.c -lt $lines[0].Length) {[coord]::new($pt.r,$pt.c+1,$lines[$pt.r][$pt.c+1],$pt.steps+1)} else {[coord]::new(0,0,[Byte][Char]'Z',0)}
    foreach($card in @($up,$down,$left,$right)) {
        if ((([byte][char]$card.value)-1) -le ([byte][char]$pt.value)) {
            if ($DONE[$card.r][$card.c] -eq "0") {
                $TODO.Enqueue($card)
                if (($card.r -eq $target.r) -and ($card.c -eq $target.c) ) {
                    Write-Host $card.Steps
                    Break
                }
            }
        }
    }
    $DONE[$pt.r][$pt.c] = $pt.psobject.Copy()
    Write-Host $TODO.Count "remaining..."

}
Write-Host "no more to do!"
foreach($coordSet in $DONE){
    foreach($coord in $coordSet) {
        if (($coord -ne "0")-and($coord.Value -ne "97")) {
            Write-Host $coord.r $coord.c $coord.value $coord.steps
        }

    }
}