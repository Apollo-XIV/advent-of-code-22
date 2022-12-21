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


function findE($TODO,$grid) {
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
            if ($card.value -eq '&') {
                continue cards
            }

            if ((($card.ascii()+1) -ge ($pt.ascii())) -and ($grid.get($card.getrc()).steps -eq 0)) {
                $card.steps = $pt.steps + 1
                if ($card.value -eq 'a') {
                    Write-Host $card.steps
                    return
                }
                $TODO.Enqueue($card)            
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

# Done if != -1

$TODO = [System.Collections.Queue]::new()

#finds and sets target and ends
for($r=0; $r -lt $grid.x.Length ; $r++){
    for($c=0; $c -lt $grid.x[$r].Length ; $c++) {
        $finder = $grid.get(@($r,$c))
        switch($finder.ascii()) {
            69 {
                $TODO.enqueue($finder.psobject.Copy())
                $finder.value = 'z'
                $finder.steps = 0
                $grid.set($finder)
            }
        }
    }
}

findE -TODO $TODO -grid $grid