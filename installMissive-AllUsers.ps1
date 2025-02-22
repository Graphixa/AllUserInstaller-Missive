<#
.SYNOPSIS
    Installs Missive email client for all users on Windows.

.DESCRIPTION
    This script performs an automated installation of Missive email client:
    - Checks if Missive is already installed
    - Downloads the latest Missive installer
    - Performs a silent installation for all users
    - Creates shortcuts in public Start Menu and Desktop
    - Cleans up temporary files

.NOTES
    Version: 2.0
    Last Updated: 2025
    Requires: PowerShell 5.1 or later
    Run with administrative privileges
#>

Set-ExecutionPolicy Unrestricted
$ProgressPreference = 'SilentlyContinue'

$softwareName = 'Missive'
$checkLocation = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall'
$installerUrl = 'https://mail.missiveapp.com/download/win'
$tempPath = "$env:SystemDrive\Temp"
$missiveFile = "$tempPath\MissiveSetup.exe"

# Function to remove Missive installer and temp files
function Clean-TempFiles {
    try {
        Write-Host "Cleaning up temporary files and folders..."
        if (Test-Path $missiveFile) { Remove-Item $missiveFile -Force }
        if (Test-Path $tempPath) { Remove-Item $tempPath -Force }
        Start-Sleep -Seconds 2
    } catch {
        Write-Host -BackgroundColor Red -ForegroundColor White " Error: Failed to remove temporary files "
        Write-Host $_.Exception.Message
        Start-Sleep -Seconds 3
    }
}

# Check if Missive is already installed
if (Get-ChildItem $checkLocation -Recurse -ErrorAction Stop | 
    Get-ItemProperty -name DisplayName -ErrorAction SilentlyContinue | 
    Where-Object {$_.DisplayName -Match "^$softwareName.*"}) {
    Write-Host -ForegroundColor Yellow "$softwareName is already installed. No action required."
    exit
}

Write-Host -ForegroundColor Yellow "$softwareName is NOT installed. Installing Now..."

# Create Temp Folder
[void](New-Item -ItemType Directory -Force -Path $tempPath)

# Download Missive installer
try {
    Write-Host "Downloading Missive installer..."
    Invoke-WebRequest -Uri $installerUrl -OutFile $missiveFile -ErrorAction Stop
} catch {
    Write-Host -BackgroundColor Red -ForegroundColor White " Error: Download failed "
    Write-Host $_.Exception.Message
    Clean-TempFiles
    exit 1
}

# Install Missive silently for all users
try {
    Write-Host "Installing Missive for all users..."
    $process = Start-Process -Wait -FilePath $missiveFile -ArgumentList "/S /D=$env:SystemDrive\$softwareName" -PassThru
    if ($process.ExitCode -ne 0) {
        throw "Installation failed with exit code: $($process.ExitCode)"
    }
} catch {
    Write-Host -BackgroundColor Red -ForegroundColor White " Error: Installation failed "
    Write-Host $_.Exception.Message
    Clean-TempFiles
    exit 1
}

# Create shortcuts for all users
try {
    Write-Host "Creating shortcuts for all users..."
    $missiveExecutable = "$env:SystemDrive\$softwareName\Missive.exe"
    $WScriptObj = New-Object -ComObject ("WScript.Shell")

    # Create Start Menu shortcut
    $startMenuPath = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Missive.lnk"
    $shortcutStart = $WscriptObj.CreateShortcut($startMenuPath)
    $shortcutStart.TargetPath = $missiveExecutable
    $shortcutStart.Save()

    # Create Desktop shortcut
    $desktopPath = "$env:Public\Desktop\Missive.lnk"
    $shortcutDesktop = $WscriptObj.CreateShortcut($desktopPath)
    $shortcutDesktop.TargetPath = $missiveExecutable
    $shortcutDesktop.Save()
} catch {
    Write-Host -BackgroundColor Red -ForegroundColor White " Error: Failed to create shortcuts "
    Write-Host $_.Exception.Message
}

# Cleanup
Clean-TempFiles
Write-Host -ForegroundColor Green "Missive installation completed successfully!"
