class Monkey {
    [System.Collections.ArrayList]$items
    [String[]]$op = @()
    [Int]$test
    [Int]$pass
    [Int]$fail
    [Int]$inspects = 0
    
    Monkey([Int[]]$items, [String[]]$op, [Int]$test, [Int]$pass, [Int]$fail) {
        $this.items = [System.Collections.ArrayList]$items
        $this.op = $op
        $this.test = $test
        $this.pass = $pass
        $this.fail = $fail
    }

    [void]add($item){
        $this.items.add($item)
    }
    [void]inspect(){
        $this.inspects += 1
        if ($this.op[0] -eq 'old') {$this.op = $this.items[0]}
        if ($this.op[2] -eq 'old') {$this.op = $this.items[0]}
        switch ($this.op[1]) {
            '*' {$this.items[0] = [Math]::Floor(($this.op[0] * $this.op[2])/3)}
            '+' {$this.items[0] = [Math]::Floor(($this.op[0] + $this.op[2])/3)}
        }
    }
    [Int[]]testprog(){
        $temp = $this.items[0].psobject.copy()
        $this.items.RemoveAt(0)
        if (($temp % $this.test) -eq 0) {
            return @($this.pass, $temp)
        }
        return @($this.fail, $temp)
    }
    [System.Collections.ArrayList]around(){
        $out = [System.Collections.ArrayList]::new()
        while($this.items.Count -gt 0) {
            $this.inspect()
            $out.add($this.testprog())
        }
        return $out
    }
}

function newMonkey($inputs) {
    $items = $inputs[0].Substring(18,($inputs[0].Length-18)) -split ", "
    foreach($item in $items) {
        $item = [Int]$item
    }
    $op = $inputs[1].Substring(19,($inputs[1].Length-19)) -split " "
    $test = $inputs[2].Substring(21,($inputs[2].Length-21))
    $ver = $inputs[3].Substring(29,($inputs[3].Length-29))
    $fal = $inputs[4].Substring(30,($inputs[4].Length-30))
    $newMonkey = [Monkey]::new($items, $op, $test, $ver, $fal)
    return $newMonkey
}

function parseMonkeys($file) {
    $monkeys = @()
    $lines = Get-Content $file
    :lines for($i=0; $i -lt $lines.Length; $i++) {
        if ("" -eq $lines[$i]) {
            continue lines
        }
        if ($lines[$i].Substring(0,6) -eq 'Monkey') {
            $tempMonkey = newMonkey($lines[($i+1)..($i+5)])
            $monkeys += $tempMonkey
            $i += 6
        }
    }
    return $monkeys
}

$monkeys = parseMonkeys("inputs/day11.txt")

for($j=0; $j -lt 20; $j++) {
    Write-Host "he"
    for ($i=0; $i -lt $monkeys.Length ; $i++) {
        foreach($item in $monkeys[$i].around()) {
            $monkeys[$item[0]].add($item[1])
        }
    }
}
foreach($monkey in $monkeys) {
    Write-Host $monkey.inspects
}