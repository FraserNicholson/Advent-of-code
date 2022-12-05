[int]$currentMaxCalories = 0
[int]$currentMaxCalories2 = 0
[int]$currentMaxCalories3 = 0

$numbers = ,0;

foreach ($line in Get-Content ./input.txt) {
    $currentElfCalories

    if ('' -eq $line) {

        $numbers += $currentElfCalories

        $currentElfCalories = 0
    } else {
        $currentElfCalories = [int]$currentElfCalories + [int]$line
    }
}


$OrderedNums = $numbers | sort -Descending


$currentMaxCalories = $OrderedNums[0]
$currentMaxCalories2 = $OrderedNums[1]
$currentMaxCalories3 = $OrderedNums[2]

$total = $currentMaxCalories + $currentMaxCalories2 + $currentMaxCalories3

Write-Host "Total"
Write-Host $total
