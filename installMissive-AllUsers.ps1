Set-ExecutionPolicy Unrestricted

$ProgressPreference = 'SilentlyContinue'

$softwareName = 'Missive'
$checkLocation = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall'

# Check if Missive is already installed and if not run a script
if (Get-ChildItem $checkLocation -Recurse -ErrorAction Stop | Get-ItemProperty -name DisplayName -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -Match "^$softwareName.*"})
     {write-host -ForegroundColor Yellow $softwareName "is already installed. No action required."
      break;} 

else {Write-Host -ForegroundColor Yellow $softwareName "is NOT installed. Installing Now..."

# // INSTALLATION SCRIPT GOES HERE //

# Function to remove Missive installer and temp files upon script completion or failure
function cleanupTempFiles {
          try {
                Write-Host "Cleaning up temp files and folders. Please wait..."
                   Remove-Item $missiveFile -Force
                   Remove-Item $jsonFile -Force
                   Remove-Item $tempPath -Force
                   Start-Sleep -Seconds 10
                return} 

        catch {
                Write-Host -BackgroundColor Red -ForegroundColor White " Error "
                Write-Host "Failed to remove temporary files and folders. These will need to be removed manually."
                Write-Host
                Write-Host $_.Exception.Message
                Start-Sleep -Seconds 10
             break;}
             }

    # Set Default Path for Temporarily Downloaded Files + JSON File Name
        $tempPath="$env:SystemDrive\Temp\"
        $jsonFile=$tempPath+"latest.json"

    # URL containing the latest JSON file for Missive version information (Hosted by Missiveapp.com)
        $jsonUrl = 'https://missiveapp.com/download/latest.json'

    # Create Temp Folder in the Root of the System Drive
        [void](New-Item -ItemType Directory -Force -Path $tempPath)

    # Download JSON file to Temp Folder Location
    

        try {        
                Invoke-RestMethod -Method Get -Uri $jsonUrl -OutFile $jsonFile} 
        catch {
                Write-Host -BackgroundColor Red -ForegroundColor White " Error "
                Write-Host "Missive Failed to install properly"
                Write-Host
                Write-Host $_.Exception.Message
                pause
                
                cleanupTempFiles
            break;}

    #  Search JSON file and return the URL of the latest Missive release for Windows
        $json = (Get-Content $jsonFile -Raw) | ConvertFrom-Json
        $version = $json.version
        $windowsDL = $json.downloads.windows.direct
        $missiveFile = "$tempPath\$softwareName-$version.exe"

      
    # Download latest Missive version for Windows from hosted JSON file values
        try {
                Write-Host "Downloading Missive Installer from https://missiveapp.com"
                Write-Host "Please wait... This could take a while."
                Invoke-WebRequest -Method Get -Uri $windowsDL -OutFile $missiveFile} 

        catch {
                Write-Host -BackgroundColor Red -ForegroundColor White " Error "
                Write-Host "Download of Missive Installer Failed"
                Write-Host
                Write-Host $_.Exception.Message
                pause
                
                cleanupTempFiles
            break;}


    # Install silently for all users (/S = Install Silently /D = Set Custom Install Location - e.g. C:\Missive\
          try {
                Write-Host "Installing Missive for all Users. Please wait..."
                Start-Process -Wait -FilePath $missiveFile -ArgumentList "/S /D=$env:SystemDrive\$softwareName" -passthru} 

        catch {
                Write-Host -BackgroundColor Red -ForegroundColor White " Error "
                Write-Host "Missive Failed to install properly"
                Write-Host
                Write-Host $_.Exception.Message
                pause
                
                cleanupTempFiles
            break;}
       

    
    # Create Shortcuts from Missive.exe for all users in Windows public Start Menu & Desktop
 
            $missiveExecutable = "$env:SystemDrive\$softwareName\Missive.exe"
            $startMenuPath = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Missive.lnk"
            $desktopPath = "$env:Public\Desktop\Missive.lnk"
            $WScriptObj = New-Object -ComObject ("WScript.Shell")

          try {
                Write-Host "Creating desktop and start menu shortcuts all Users. Please wait..."

                    #Create Shortcut in All-Users Start Menu
                    $shortcutStart = $WscriptObj.CreateShortcut($startMenuPath)
                    $shortcutStart.TargetPath = $missiveExecutable
                    $shortcutStart.Save()

                    #Create Shortcut in All-Users Desktop
                    $shortcutDesktop = $WscriptObj.CreateShortcut($desktopPath)
                    $shortcutDesktop.TargetPath = $missiveExecutable
                    $shortcutDesktop.Save()} 

        catch {
                Write-Host -BackgroundColor Red -ForegroundColor White " Error "
                Write-Host "Failed to create desktop and start menu shortcuts"
                Write-Host
                Write-Host $_.Exception.Message
                Start-Sleep -Seconds 3
                }
    

# Cleanup and remove Missive installer and temp files after installation is complete
 cleanupTempFiles

}
