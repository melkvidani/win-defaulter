# Installation script for Set-DefaultApp module

Write-Host "Installing Set-DefaultApp PowerShell Module..." -ForegroundColor Cyan

# Get the module directory
$moduleDir = $PSScriptRoot
$moduleName = "Set-DefaultApp"

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Warning "For system-wide installation, please run as Administrator."
    Write-Host "Installing for current user only..." -ForegroundColor Yellow
}

# Determine installation path
if ($isAdmin) {
    $installPath = "$env:ProgramFiles\WindowsPowerShell\Modules\$moduleName"
} else {
    $installPath = "$HOME\Documents\WindowsPowerShell\Modules\$moduleName"
}

# Create directory if it doesn't exist
if (-not (Test-Path $installPath)) {
    New-Item -Path $installPath -ItemType Directory -Force | Out-Null
}

# Copy the module file
$moduleFile = Join-Path $moduleDir "$moduleName.psm1"
if (Test-Path $moduleFile) {
    Copy-Item -Path $moduleFile -Destination $installPath -Force
    Write-Host "✓ Module installed to: $installPath" -ForegroundColor Green
} else {
    Write-Error "Module file not found: $moduleFile"
    exit 1
}

# Import the module to make it available immediately
Import-Module $moduleName -Force

Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "`nUsage:" -ForegroundColor Cyan
Write-Host "  Fuck-Microsoft vlc    # Set VLC as default media player" -ForegroundColor White
Write-Host "`nNote: Run PowerShell as Administrator when using this command." -ForegroundColor Yellow
