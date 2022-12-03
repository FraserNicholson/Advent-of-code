# Convert lowercase letters to values from 1-26 - ASCII is 97 - 122 
# Convert uppercase letters to values from 27-52 - ASCII is 65 - 90

function Get-PriorityValue {
    param (
        [string]$character
    )

    $asciiValue = [byte][char]$character
    
    $mappedValue = 0

    if ($asciiValue -gt 96) {
        $mappedValue = [int]$asciiValue - 96
    }

    if (($asciiValue -gt 64) -and ($asciiValue -lt 91)) {
        $mappedValue = [int]$asciiValue - 38
    }

    return $mappedValue
}

function Get-DuplicatedCharacter {
    param (
        [string]$stringInput
    )

    $stringMidPoint = $stringInput.Length / 2

    $firstHalfOfString = $stringInput.Substring(0, $stringMidPoint)

    $secondHalfOfString = $stringInput.Substring($stringMidPoint, $stringMidPoint)

    $characters = $firstHalfOfString.ToCharArray()

    foreach ($char in $characters) {
        if ($secondHalfOfString -cmatch $char) {
            return $char
        }
    }
}

function Get-DuplicatedCharacterFromArray {
    param (
        [string[]]$stringArrayInput
    )
    
    $duplicatedCharacterArray = @()

    # Get duplicated items from first 2 strings
    $firstStringChars = $stringArrayInput[0].ToCharArray()

    foreach ($char in $firstStringChars) {
        if ($stringArrayInput[1] -cmatch $char) {
            $duplicatedCharacterArray += $char
        }
    }

    # Get duplicated character that is also in final string
    foreach ($dupChar in $duplicatedCharacterArray) {
        if ($stringArrayInput[2] -cmatch $dupChar) {
            return $dupChar
        }
    }
}

$priorityCount = 0

$count = 1
$stringArray = @()

$newPriorityCount = 0

foreach ($line in Get-Content -Path ./input.txt) {
    # Part 1
    $duplicatedCharacter = Get-DuplicatedCharacter -stringInput $line

    $priorityValue = Get-PriorityValue -character $duplicatedCharacter

    $priorityCount += $priorityValue

    # Part 2
    $stringArray += $line

    if ($count % 3 -eq 0) {
        $newDuplicatedChar = Get-DuplicatedCharacterFromArray -stringArrayInput $stringArray

        $newPriorityValue = Get-PriorityValue -character $newDuplicatedChar

        $newPriorityCount += $newPriorityValue

        $stringArray = @()
    }

    $count++
}

Write-Host $priorityCount
Write-Host $newPriorityCount