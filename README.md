# win-defaulter

A PowerShell utility for easily setting default applications on Windows. Because setting defaults shouldn't require clicking through 47 different menus.

## Features

- Simple command-line interface for setting default apps
- Currently supports: VLC Media Player
- Safe: Only modifies file associations, no malicious code
- Handles 25+ common video and audio file formats

## Installation

### Quick Install

1. Clone or download this repository
2. Open PowerShell as Administrator
3. Navigate to the repository directory
4. Run the installation script:

```powershell
.\Install.ps1
```

### Manual Install

1. Copy `Set-DefaultApp.psm1` to your PowerShell modules directory:
   - System-wide: `C:\Program Files\WindowsPowerShell\Modules\Set-DefaultApp\`
   - User-only: `C:\Users\<YourUsername>\Documents\WindowsPowerShell\Modules\Set-DefaultApp\`

2. Import the module:
```powershell
Import-Module Set-DefaultApp
```

## Usage

### Set VLC as Default Media Player

```powershell
Screw-Microsoft vlc
```

This will set VLC as the default application for:
- **Video formats**: mp4, mkv, avi, mov, wmv, flv, webm, m4v, mpg, mpeg, m2v, 3gp, ogv
- **Audio formats**: mp3, flac, wav, aac, ogg, wma, m4a, opus, ape, aiff

### Requirements

- Windows PowerShell 5.1 or later
- Administrator privileges
- VLC Media Player must be installed

## How It Works

The utility uses Windows' built-in `assoc` and `ftype` commands to safely modify file associations. It:

1. Checks if you're running as Administrator
2. Verifies VLC is installed on your system
3. Sets file associations for common media formats
4. Updates the Windows registry user preferences

**No sketchy stuff** - just standard Windows file association APIs.

## Supported Applications

- [x] VLC Media Player
- [ ] More coming soon...

## Contributing

Want to add support for more applications? PRs welcome!

## License

MIT - Do whatever you want with it

## FAQ

**Q: Why does this need Administrator privileges?**
A: Modifying system file associations requires admin rights on Windows.

**Q: Is this safe?**
A: Yes. The script only modifies file associations using standard Windows APIs. No sketchy registry hacks or system modifications.

**Q: Will this break my existing associations?**
A: It will override your current default apps for the file types it manages. You can always change them back through Windows Settings.

**Q: Why "Screw-Microsoft"?**
A: Because navigating Windows Settings to change default apps is unnecessarily painful, and sometimes you just need to express your feelings.