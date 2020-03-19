﻿function KillThatProcess{
    Param(
        [Parameter(mandatory)] [string]$processName
    )

    $processes = $null
    $processes = Get-Process $processName -ErrorAction Ignore

    if($processes -eq $null){
        Write-host "Error! No processes with the name $($processName) are open!" -BackgroundColor Red -ForegroundColor Black
    }else{
        $answer = Read-Host -Prompt "There are $($processes.length) processe(s) with the name $($processName), proceed? Y/N"
        if($answer -ne "y"){ #No need for .ToLower(), because Powershell
            Write-Host "You cancelled the operation." -BackgroundColor Red -ForegroundColor Black
        }else{
            $processes | kill
            Write-Host "Succesfully killed all the processes." -BackgroundColor Green -ForegroundColor Black
        }
    }
}


function Bamboozle{
    Param(
        [string]$location = $PSScriptRoot
    )

    $location = $location + "\"

    [char] $letter = Get-Random -Minimum 65 -Maximum 91

    $image = Get-ChildItem -Path ($PSScriptRoot + "\texts\") -Filter $letter* -ErrorAction Ignore

    if($image -eq $null){
        Write-Host "Its the letter $($letter), okay? I Can't find my images to display :( Put the texts folder in the same directory as the script you meanie winnie :("
    }else{
        $image | Get-Content -Raw| Write-Host
        Write-Host "Try to guess the ascii minecraft art. It starts with $($letter)! Some letters don't have any though :("
    }

    $files = Get-ChildItem -Path $location -Filter *$letter* -File 

    if($files -eq $null){
        Write-Host "Unfortunately, we haven't found any files containing the letter $($letter)"
    }else{
        $files | Remove-Item -WhatIf
    }

}