class point {
    [Int]$r
    [Int]$c
    [Char]$value
    [Int]$steps
    [Boolean]$visited = $false

    point ($r,$c,$v,$s) {
        $this.r = $r
        $this.c = $c
        $this.value = $v
        $this.steps = $s
    }

    [Int[]] getrc () {
        return @($this.r,$this.c)
    }

    [Int] ascii() {
        return [byte][char]$this.value
    }

    update($grid) {
        $this.r = $grid.x[$this.r][$this.c].r
        $this.c = $grid.x[$this.r][$this.c].c
        $this.value = $grid.x[$this.r][$this.c].value
        $this.steps = $grid.x[$this.r][$this.c].steps
    }
}

class grid {
    [point[][]]$x

    grid ($r,$c) {
        # creates grid of dimensions r x c
        $this.x = [point[][]]::new($r)
        for($i=0; $i -lt $r;$i++) {
            $this.x[$i] = [point[]]::new($c)
        }
    }

    [point]get ($coords) {
        if( ($coords[0] -lt 0) -or
            ($coords[1] -lt 0) -or
            ($coords[0] -ge $this.x.Length) -or
            ($coords[1] -ge $this.x[0].Length)) {
            return [point]::new(0,0,'&',0)
        }
        
        return $this.x[$coords[0]][$coords[1]]
    }

    set ($pt) {
        $this.x[$pt.r][$pt.c] = $pt
    }
}

function part1($TODO, $card, $target, $pt) {
    $check = (($card.ascii()-1) -le ($pt.ascii()))
    if (($check) -and (-not $card.visited)) {
        $TODO.Enqueue($card)
        if (($card.r -eq $target.r)-and($card.c -eq $target.c)){
            Write-Host $card.steps
            exit
        }
    }
    return $TODO
}

function part2($TODO,$card,$target,$pt) {
    $check = (($card.ascii()+1) -ge ($pt.ascii()))
    if (($check) -and (-not $card.visited)) {
        if ($card.ascii() -eq $target) {
            Write-Host $card.steps
            exit
        }
        $TODO.Enqueue($card)  
    }
    return $TODO

}
function findE($TODO,$grid,$target,$part1) {
    while($true) {
        if ($TODO.Count -eq 0) {
            Write-Host "ran out of cells!"
            break
        }
        $pt = $TODO.Dequeue()
        $pt.update($grid)
        if ($pt.visited) {
            continue
        }
        $up = @(($pt.r-1),$pt.c)
        $down = @(($pt.r+1),$pt.c)
        $left = @($pt.r,($pt.c-1))
        $right = @($pt.r,($pt.c+1))
        :cards foreach($card in @($up,$down,$left,$right)) {
            $card = $grid.get($card)
            $card.steps = $pt.steps + 1
            if ($card.value -eq '&') {
                continue cards
            }
            if ($card.ascii() -eq $target) {
                Write-Host $card.steps
                return
            }
            if ($part1) {
                $TODO = part1 -TODO $TODO -card $card -target $target -pt $pt
            } else {
                $TODO = part2($TODO,$card,$target,$pt)
            }
        }
        
        Write-Host "working..." $TODO.Count "|" $pt.getrc() "|" $pt.value "|" $pt.steps
        $pt.visited = $true
        $grid.set($pt)
    }
}

$lines = Get-Content "inputs/day12.txt"
$grid  = [grid]::new($lines.Length,$lines[0].Length)
for($r=0; $r -lt $lines.Length ; $r++){
    for($c=0; $c -lt $lines[$r].Length ; $c++) {
        $pt = [point]::new($r,$c,$lines[$r][$c],0)
        $grid.set($pt)
    }
}

$TODO = [System.Collections.Queue]::new()
# part 1, set target to E, start to S, working ASCENDING
# make temporary grid
$part1 = $grid.psobject.Copy()
# sets TODO to start point
for($r=0; $r -lt $part1.x.Length ; $r++){
    for($c=0; $c -lt $part1.x[$r].Length ; $c++) {
        $finder = $part1.get(@($r,$c))
        switch($finder.ascii()) {
            83 {
                $TODO.enqueue($finder.psobject.Copy())
                $finder.value = 'a'
                $finder.steps = 0
                $part1.set($finder)
            }
            69 {
                $target = $finder.psobject.Copy()
                $finder.value = 'z'
                $grid.set($finder)
            }
        }
    }
}

findE -TODO $TODO -grid $part1 -target $target -part1 $true

# part 2, set target to any A, start to E, working DESCENDING