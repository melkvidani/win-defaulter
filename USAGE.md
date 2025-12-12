# Usage Guide

## Quick Start

After installation, simply run:

```powershell
# Open PowerShell as Administrator (required!)
Screw-Microsoft vlc
```

## Step-by-Step Guide

### 1. Check if VLC is Installed

The script will automatically check for VLC in standard installation locations:
- `C:\Program Files\VideoLAN\VLC\vlc.exe`
- `C:\Program Files (x86)\VideoLAN\VLC\vlc.exe`

If VLC is not found, you'll see an error message with a download link.

### 2. Running the Command

```powershell
# Make sure you're running PowerShell as Administrator
Screw-Microsoft vlc
```

### 3. What Happens

The script will:
1. ✓ Check for Administrator privileges
2. ✓ Locate VLC installation
3. ✓ Configure file associations for 25+ media formats
4. ✓ Display progress for each file type
5. ✓ Show a summary of successful/failed configurations

### Expected Output

```
Setting VLC as default media player...
Found VLC at: C:\Program Files\VideoLAN\VLC\vlc.exe

Configuring file associations for 25 file types...
  ✓ .mp4
  ✓ .mkv
  ✓ .avi
  ✓ .mov
  ...

Completed!
Successfully configured: 25 file types

VLC is now set as your default media player.
You may need to restart File Explorer or log out/in for all changes to take effect.
```

## Troubleshooting

### "This script requires Administrator privileges"

**Solution**: Right-click PowerShell and select "Run as Administrator"

### "VLC Media Player not found"

**Solution**:
1. Install VLC from https://www.videolan.org/vlc/
2. Make sure it's installed in the default location
3. Run the script again

### "Execution of scripts is disabled on this system"

**Solution**: Enable script execution (run as Administrator):
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Changes don't take effect immediately

**Solution**:
1. Restart File Explorer: `Stop-Process -Name explorer`
2. Or log out and log back in
3. Or restart your computer

## Advanced Usage

### Import the Module Manually

```powershell
Import-Module .\Set-DefaultApp.psm1 -Force
```

### Check Available Functions

```powershell
Get-Command -Module Set-DefaultApp
```

### Get Help

```powershell
Get-Help Screw-Microsoft -Full
```

## Reverting Changes

To revert to Windows Media Player or another default:

1. Open Windows Settings
2. Go to Apps → Default apps
3. Search for "Video player" or "Music player"
4. Select your preferred application

Or use Windows' built-in command:
```powershell
# Example: Set Windows Media Player for MP4
cmd /c "assoc .mp4=WMP11.AssocFile.MP4"
```
