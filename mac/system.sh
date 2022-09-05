#!/usr/bin/env bash
info "Setting macOS preferences"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# General UI/UX                                                               #
###############################################################################

process_title "General UI/UX"

process "Set computer name (as done via System Preferences → Sharing)"
sudo scutil --set ComputerName "Leonardo"
sudo scutil --set HostName "Leonardo"
sudo scutil --set LocalHostName "Leonardo"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Leonardo"

process "Set sidebar icon size to medium"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

process "Always show scrollbars"
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

process "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

process "Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

process "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

process "Disable automatic capitalization as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

process "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

process "Disable automatic period substitution as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

process "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

process "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# process_title "Input"

# process "Disable press-and-hold for keys in favor of key repeat"
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# process "Set a blazingly fast keyboard repeat rate"
# defaults write NSGlobalDomain KeyRepeat -int 3
# defaults write NSGlobalDomain InitialKeyRepeat -int 10

process "Set language and text formats"

defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# process "Set the timezone; see `sudo systemsetup -listtimezones` for other values"
# sudo systemsetup -settimezone "Europe/Brussels" > /dev/null

process "Show battery percentage in status bar"
defaults write com.apple.menuextra.battery ShowPercent YES

###############################################################################
# Energy saving                                                               #
###############################################################################

process_title "Energy saving"

process "Enable lid wakeup"
sudo pmset -a lidwake 1

process "Restart automatically if the computer freezes"
sudo systemsetup -setrestartfreeze on

process "Sleep the display after 10 minutes"
sudo pmset -a displaysleep 10

process "Disable machine sleep while charging"
sudo pmset -c sleep 30

process "Set machine sleep to 5 minutes on battery"
sudo pmset -b sleep 20

###############################################################################
# Screen                                                                      #
###############################################################################

process_title "Screen"

process "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

process "Save screenshots to the Screenshots folder"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

process "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "jpg"

process "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

process "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 1

###############################################################################
# Finder                                                                      #
###############################################################################

process_title "Finder"

process "Set Desktop as the default location for new Finder windows"
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

process "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

process "Finder: Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

process "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

process "Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

process "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

process "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

process "Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

process "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

process "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

process "Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

process "Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

process "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

process "Show item info near icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

process "Show item info to the right of the icons on the desktop"
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

process "Enable snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

process "Use column view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

process "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

process "Show the ~/Library folder"
chflags nohidden ~/Library

process "Show the /Volumes folder"
sudo chflags nohidden /Volumes

process "Expand File Info panes"
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

process "Open untitled file rather than iCloud syncing crap"
defaults write -g NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

process_title "Dock & Dashboard"

process "Set the icon size of Dock items to 49 pixels"
defaults write com.apple.dock tilesize -int 49

process "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

process "Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0

process "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

process "Don’t show recent applications in Dock"
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Time Machine                                                                #
###############################################################################

process_title "Time Machine"

process "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

process_title "Activity Monitor"

process "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

process "Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

process "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

process "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Disk Utility                                                                #
###############################################################################

process_title "Disk Utility"

process "Enable the debug menu in Disk Utility"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &>/dev/null
done
