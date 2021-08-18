Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

## Test if missive exists
$installTest = Test-Path -Path "$env:LOCALAPPDATA\Programs\Missive"
If ($installTest) { 
        break;
}
Else {
 # Set Download file Destination + Filename
    $tempPath="C:\Temp\"
    $jsonFile=$tempPath+"latest.json"

# URL for latest Missive JSON file 
    $jsonUrl = 'https://missiveapp.com/download/latest.json'

# Create Temp Folder
    New-Item -ItemType Directory -Force -Path $tempPath

# Download JSON file to temp folder location
    
    Invoke-RestMethod -Method Get -Uri $jsonUrl  -OutFile $jsonFile

# Look through JSON file for Windows download URL
     $json = (Get-Content $jsonFile -Raw) | ConvertFrom-Json
     $version = $json.version
     $windowsDL = $json.downloads.windows.direct
     $missiveFile = $tempPath+"missive_latest.exe"

   # Download latest Missive version for Windows and name with Version Number // UNCOMMENT TO INCLUDE VERSION NUMBER IN FILE NAME
        #powershell -windowstyle hidden Invoke-RestMethod -Method Get -Uri $windowsDL  -OutFile $tempPath+"missive_"+$version+".exe"

   # Download latest Missive version for Windows as missive_latest.exe and install silently
        powershell -windowstyle hidden Invoke-WebRequest -Method Get -Uri $windowsDL  -OutFile $missiveFile
        Start-Process -Wait -FilePath $missiveFile -ArgumentList "/S" -passthru

   # Cleanup and remove missive installer after installation is complete
        Remove-Item $missiveFile -Force
        Remove-Item $jsonFile -Force
}

