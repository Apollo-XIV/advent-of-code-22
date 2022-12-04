$lines = Get-Content "inputs/day4.txt"
$total = @(0,0)

# PART 1
foreach ($line in $lines) {
    $a1 = $line -split ","
    $b = $a1[1] -split "-"
    $a = $a1[0] -split "-"
    if  (   (([Int]$a[0] -le [Int]$b[0]) -and ([Int]$a[1] -ge [Int]$b[1]))`
        -or (([Int]$b[0] -le [Int]$a[0]) -and ([Int]$b[1] -ge [Int]$a[1]))  ) {
        $total[0] += 1
    }
}

# PART 2
foreach ($line in $lines) {
    $a1 = $line -split ","
    $b = $a1[1] -split "-"
    $a = $a1[0] -split "-"
    if  (   (([Int]$a[0] -le [Int]$b[0]) -and ([Int]$a[1] -ge [Int]$b[0]))`
        -or (([Int]$b[0] -le [Int]$a[0]) -and ([Int]$b[1] -ge [Int]$a[0]))`
        -or (([Int]$a[0] -ge [Int]$b[0]) -and ([Int]$a[1] -le [Int]$b[0]))`
        -or (([Int]$b[0] -le [Int]$a[0]) -and ([Int]$b[1] -ge [Int]$a[0]))  )
        {
        $total[1] += 1
    }
}

Write-Host $total

<#

a1 <= b1 and a2 >= b2
or
b1 <= a1 and b2 >= a2

#>