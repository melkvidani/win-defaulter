function Fuck-Microsoft {
    <#
    .SYNOPSIS
        Sets default applications for common file types.

    .DESCRIPTION
        A PowerShell utility to set default applications. Currently supports VLC media player.
        This script safely modifies Windows file associations to set your preferred default apps.

    .PARAMETER App
        The application to set as default. Currently supported: 'vlc'

    .EXAMPLE
        Fuck-Microsoft vlc
        Sets VLC as the default media player for common video and audio formats.

    .NOTES
        Requires Administrator privileges to modify system file associations.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet('vlc')]
        [string]$App
    )

    # Check if running as Administrator
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isAdmin) {
        Write-Warning "This script requires Administrator privileges. Please run PowerShell as Administrator."
        return
    }

    switch ($App.ToLower()) {
        'vlc' {
            Set-VLCAsDefault
        }
        default {
            Write-Error "Unsupported application: $App"
        }
    }
}

function Set-VLCAsDefault {
    <#
    .SYNOPSIS
        Sets VLC Media Player as the default for common media file types.
    #>

    Write-Host "Setting VLC as default media player..." -ForegroundColor Cyan

    # Check if VLC is installed
    $vlcPaths = @(
        "${env:ProgramFiles}\VideoLAN\VLC\vlc.exe",
        "${env:ProgramFiles(x86)}\VideoLAN\VLC\vlc.exe"
    )

    $vlcPath = $vlcPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $vlcPath) {
        Write-Error "VLC Media Player not found. Please install VLC first."
        Write-Host "Download VLC from: https://www.videolan.org/vlc/" -ForegroundColor Yellow
        return
    }

    Write-Host "Found VLC at: $vlcPath" -ForegroundColor Green

    # Common video file extensions
    $videoExtensions = @(
        '.mp4', '.mkv', '.avi', '.mov', '.wmv', '.flv', '.webm',
        '.m4v', '.mpg', '.mpeg', '.m2v', '.3gp', '.ogv'
    )

    # Common audio file extensions
    $audioExtensions = @(
        '.mp3', '.flac', '.wav', '.aac', '.ogg', '.wma', '.m4a',
        '.opus', '.ape', '.aiff'
    )

    $allExtensions = $videoExtensions + $audioExtensions

    Write-Host "`nConfiguring file associations for $($allExtensions.Count) file types..." -ForegroundColor Cyan

    $successCount = 0
    $failCount = 0

    foreach ($ext in $allExtensions) {
        try {
            # Get the ProgID for VLC
            $progId = "VLC$ext"

            # Set the file association
            $null = cmd /c "assoc $ext=$progId" 2>&1
            $null = cmd /c "ftype $progId=`"$vlcPath`" `"%1`"" 2>&1

            # Also update user choice (this is the modern way)
            try {
                $null = New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$ext\UserChoice" `
                    -Name "ProgId" -Value $progId -PropertyType String -Force -ErrorAction SilentlyContinue
            } catch {
                # UserChoice is protected, but we can still set the association via assoc/ftype
            }

            $successCount++
            Write-Host "  ✓ $ext" -ForegroundColor Green
        }
        catch {
            $failCount++
            Write-Host "  ✗ $ext - $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    Write-Host "`nCompleted!" -ForegroundColor Cyan
    Write-Host "Successfully configured: $successCount file types" -ForegroundColor Green

    if ($failCount -gt 0) {
        Write-Host "Failed to configure: $failCount file types" -ForegroundColor Yellow
    }

    Write-Host "`nVLC is now set as your default media player." -ForegroundColor Green
    Write-Host "You may need to restart File Explorer or log out/in for all changes to take effect." -ForegroundColor Yellow
}

# Export the main function
Export-ModuleMember -Function Fuck-Microsoft
