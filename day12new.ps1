class point {
    [Int]$r
    [Int]$c
    [Int]$value
    [Int]$steps

    point ($r,$c,$v,$s) {
        $this.r = $r
        $this.c = $c
        $this.value = $v
        $this.steps = $s
    }

    [Int[]] getrc ($r, $c) {
        return @($r,$c)
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
        return $this.x[$coords[0]][$coords[1]]
    }

}

$grid = [grid]::new(4,5)

$grid.x.Length
$grid.x[0].Length
$grid.x[2][2] = [point]::new(100,0,0,0)
Write-Host $grid.get(@(2,2)).r