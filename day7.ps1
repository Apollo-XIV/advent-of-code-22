function Path-Gen([string[]]$path) {
    return (($path -join '/'))
}

$lines = Get-Content "inputs/day7.txt"
$dirs = @()
$dirV = @()
for ($i=0; $i -lt $lines.Length;$i++) {
    if ($lines[$i].Substring(0,1) -match '\d') {
        $ig = 0
        $path = @()
        for ($j=$i; $j -ne -1;$j--) {
            if ($lines[$j].Substring(0, 4) -eq "$ cd") {
                if ($lines[$j].Substring(5,($lines[$j].Length - 5)) -eq "..") {
                    $ig += 1
                } elseif ($ig -ne 0) {
                    $ig -= 1
                } else {
                    $path = @(($lines[$j].Substring(5,($lines[$j].Length - 5)))) + $path
                }
            }
        }
        for ($k=0; $k -lt $path.Length;$k++) {
            if (-not $dirs.Contains( $(Path-Gen($path[$k..(- 0)])) )) {
                $dirs += @($(Path-Gen($path[$k..(- 0)])))
                $dirV += @(0)
            }

            $dirV[$dirs.IndexOf($(Path-Gen($path[$k..(- 0)])))] += [Int]($lines[$i] -replace '[^0-9]','')
        }
    }
}

$sum = 0
for ($i=0; $i -lt $dirs.Length;$i++) {
    if ($dirV[$i] -le 100000) {
        $sum += $dirV[$i]
    }
}
Write-Host $sum

$goal = 30000000 - (70000000 - $dirV[0]) #space used
$dirV = ($dirV | Sort-Object)
foreach($dir in $dirV) {
    if ($dir -ge $goal) {
        Write-Host $dir
        break
    }
}

<#

file path = @("file",parent,parent,parent)
cd "" add parent
cd .. remove parent

ptsd.nzh -> hsswstq -> ignore .. ----/// bntdqzs //// ---> /
/hsswstq/ptsd.nzh

zht -> dmnt -> bsjbvff -> hsswswtq -> /

directory names arent unique, however, their heritage is

so dmnt/bsjbvff/hsswstq is unique from


#>
