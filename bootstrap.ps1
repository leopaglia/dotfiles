# Remove progress bar - it slows down downloads
$ProgressPreference = 'SilentlyContinue'

# Set permission to run a remote script
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

mkdir "C:\Users\pagli\Installers"

Invoke-WebRequest -Uri "https://dl.google.com/drive-file-stream/GoogleDriveSetup.exe" -OutFile "C:\Users\pagli\Installers\googledrive.exe"

Invoke-WebRequest -Uri "http://www.epsxe.com/files/ePSXe205.zip" -OutFile "C:\Users\pagli\Installers\ePSXe205.zip"

Invoke-WebRequest -Uri "https://lol.secure.dyn.riotcdn.net/channels/public/x/installer/current/live.la2.exe" -OutFile "C:\Users\pagli\Installers\riotclient.zip"

# Install scoop.sh
Invoke-RestMethod get.scoop.sh | Invoke-Expression

scoop bucket add extras
scoop bucket add games
scoop bucket add main
scoop bucket add versions

# Programs
scoop install extras/ferdium
scoop install extras/googlechrome
scoop install extras/libreoffice
scoop install extras/spotify
scoop install extras/stash
scoop install versions/steam
scoop install extras/teamviewer
scoop install extras/winrar
scoop install versions/jdownloader

# Manga/Anime
scoop install extras/houdoku
scoop install extras/miru

# Games
scoop install games/minecraft

# Emulators
scoop install games/pegasus # Manager
scoop install games/citra # 3DS
scoop install games/bsnes-hd-beta # SNES
scoop install games/sameboy # GB / GBC
scoop install games/visualboyadvance-m # GBA
scoop install games/pcsx2 # PS2
scoop install games/ppsspp # PSP
scoop install games/rpcs3 # PS3
scoop install games/project64 # N64

# Utilities
scoop install extras/lockhunter
scoop install extras/powertoys
scoop install extras/hwmonitor
scoop install extras/coretemp
scoop install extras/fancontrol
scoop install extras/awake
scoop install extras/barrier 
scoop install extras/reicon
scoop install main/lux # Video downloader
scoop install main/youtube-dl # Video downloader
