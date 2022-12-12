class register {
    [Int]$value
    [Int[]]$cycles = @(,1)
    addx($V) {
        $this.cycles += @(,$this.value)
        $this.value += $V
        $this.cycles += @(,$this.value)
    }
    noop() {
        $this.cycles += @(,$this.value)
    }
}

class clock {
    [String[]]$next
    $instructions = [System.Collections.ArrayList]::new()
    getInstruction() {
        if ($null -ne $this.instructions[0]){
            $this.next = $this.instructions[0].psobject.copy()
            $this.instructions.RemoveAt(0)
        } else {
            $this.next = $null
        }
    }
    fetchInstructions($file) {
        $unparsed = Get-Content $file
        for($i=0; $i -lt $unparsed.Length;$i++) {
            $cmd = $unparsed[$i].Substring(0,4)
            $params = if ($unparsed[$i].Length -gt 5) {($unparsed[$i].Substring(5,($unparsed[$i].Length-5)))} else {""}
            $this.instructions.add(@($cmd, $params))
        }
    }
}

$clock = [clock]::new()
$X = [register]::new()
$X.value = 1

<#

noop --> clock.append(register.noop())
addx V --> clock.append(register.addx(V))

#>
$clock.fetchInstructions("inputs/day10.txt")
$clock.getInstruction()

while ($null -ne $clock.next) {
    switch($clock.next[0]) {
        "addx" {$X.addx($clock.next[1])}
        "noop" {$X.noop()}
    }
    $clock.getInstruction()
}



$sum = 0
for ($i=20; $i -lt $X.cycles.Length; $i += 40){
    Write-Host $X.cycles[$i-1]
    $sum += $i*[Int]$X.cycles[$i-1]
}
Write-Host $sum
$CRT = ""
for ($i=0; $i -lt $X.cycles.Length; $i++) {
    if ((($i)%40 -eq $x.cycles[$i]) -or
        (($i-1)%40 -eq $x.cycles[$i]) -or
        (($i+1)%40 -eq $x.cycles[$i]) ) {
        $CRT += "#"
    } else {
        $CRT += "."
    }
    if ($i%40 -eq 39) {
        $CRT += "`n"
    }
}

Write-Host $CRT
