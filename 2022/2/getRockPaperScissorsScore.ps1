$totalScore = 0

function GetChoice {
    param (
        [string]$oppenentChoice,
        [string]$targetResult
        )

    if ($targetResult -eq "Y") {
        return $oppenentChoice
    }

    $choiceToReturn = "A"
    
    switch ($oppenentChoice) {
        # Rock
        "A" {
            # Lose
            if ($targetResult -eq "X") {
                $choiceToReturn = "C";
            }
            # Win
            if ($targetResult -eq "Z") {
                $choiceToReturn = "B";
            }
        }
        # Paper
        "B" {
            # Lose
            if ($targetResult -eq "X") {
                $choiceToReturn = "A";
            }
            # Win
            if ($targetResult -eq "Z") {
                $choiceToReturn = "C";
            }
        }
        # Scissors
        "C" {
            # Lose
            if ($targetResult -eq "X") {
                $choiceToReturn = "B";
            }
            # Win
            if ($targetResult -eq "Z") {
                $choiceToReturn = "A";
            }
        }
        Default { $choiceToReturn = "A" }
    }

    return $choiceToReturn
}

function MapChoice{
    param (
        [string]$inputChoice
        )

    # Convert to the same characters
    switch ($inputChoice) {
        "X" { $inputChoice = "A" }
        "Y" { $inputChoice = "B" }
        "Z" { $inputChoice = "C" }
        Default { $inputChoice = "A" }
    }

    return $inputChoice
}

function GetInteractionScore {
    param (
    [string]$oppenentChoice,
    [string]$myChoice
    )

    $score = 0;

    if ($myChoice -eq $oppenentChoice) {
        return 3;
    }

    switch ($myChoice) {
        # Rock
        "A" {
            # Paper
            if ($oppenentChoice -eq "B") {
                $score = 0;
            }

            # Scissors
            if ($oppenentChoice -eq "C") {
                $score = 6
            }
        }
        # Paper
        "B" {
            # Rock
            if ($oppenentChoice -eq "A") {
                $score = 6;
            }

            # Scissors
            if ($oppenentChoice -eq "C") {
                $score = 0
            }
        }
        # Scissors
        "C" {
            # Paper
            if ($oppenentChoice -eq "B") {
                $score = 6;
            }

            # Rock
            if ($oppenentChoice -eq "A") {
                $score = 0;
            }
        }
        Default { $score = 0 }
    }

    return $score
}

function GetSelectionScore { 
    param (
    [string]$myChoice
    )

    $selectedScore = 0

    switch ($myChoice) {
        "X" { $selectedScore = 1 }
        "Y" { $selectedScore = 2 }
        "Z" { $selectedScore = 3 }
        Default { $selectedScore = 1 }
    }

    return $selectedScore
}

$newTotalScore = 0

foreach ($line in Get-Content ./input.txt) {
    $opponentInput = $line.Substring(0,1)

    $myInput = $line.Substring(2,1)

    $mappedInput = MapChoice -inputChoice $myInput

    $selectionScore = GetSelectionScore -myChoice $myInput
    $interactionScore = GetInteractionScore -myChoice $mappedInput -oppenentChoice $opponentInput

    $score = $selectionScore + $interactionScore

    $totalScore += $score

    # Part B

    $newInteractionScore = 0;
    switch ($myInput) {
        "X" { $newInteractionScore = 0 }
        "Y" { $newInteractionScore = 3 }
        "Z" { $newInteractionScore = 6 }
        Default { $newInteractionScore = 1 }
    }

    $newSelectionScore = 0;

    Write-Host "Input 1 " $opponentInput
    Write-Host "Input 2 " $myInput

    $newChoice = GetChoice -oppenentChoice $opponentInput -targetResult $myInput

    Write-Host "Mapped input " $newChoice

    switch ($newChoice) {
        "A" { $newSelectionScore = 1 }
        "B" { $newSelectionScore = 2 }
        "C" { $newSelectionScore = 3 }
        Default { $newSelectionScore = 1 }
    }

    Write-Host "New selection score " $newSelectionScore

    Write-Host "New interaction score " $newInteractionScore

    $newScore = $newInteractionScore + $newSelectionScore

    $newTotalScore += $newScore
}

Write-Host "Part A:"
Write-Host $totalScore

Write-Host "Part B:"
Write-Host $newTotalScore

# Rock A,X - paper B,Y - scissors C,Z