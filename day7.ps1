<#

cd means move pointer
".." = move up
else move down

ls add contents to subarray

class directory {
    self.contents = @()
    self.parent = [directory]
}

class file {
    self.size = [Int]
    self.parent = [directory]
}

to sum file sizes for each get all directory names and for each sum files that can chase their heritage


#>

class dir{
    [string]$name
    [Int]$id
    [dir[]]$contents
    [string]$parent

    [void] AddChild([dir]$new) {
        $this.contents += @($new)
    }

    [Int] findDir($target) {
        for ($i=0; $i -lt $this.contents.Length; $i++) {
            if (($this.contents[$i]).id -eq $target) {
                return $i
            }
        }
        return 0
    }
}

class file{
    [string]$name
    [Int]$id
    [string]$size
    [string]$parent
}

class pointer{
    [dir]$wd

    [void] moveup() {
        $this.wd = $this.wd.parent
    }

    [void] movedown($target) {
        foreach($dir in $this.wd.content) {
            if ($target -eq $dir.name) {
                $this.wd = $dir
            }
        }

        $this.wd.AddChild($target)
        $this.movedown($target)

    }
}

$lines = Get-Content "input\day7.txt"
[dir]$root = [dir]::new()
[pointer]$ptr = [pointer]::new()
$ptr.wd = $root

foreach ($line in $lines) {
    if ($line.Substring(0,4) -eq "$ cd") {

    }
}