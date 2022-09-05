#!/bin/bash
brew install dockutil

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Ferdi.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"

dockutil --no-restart --add /Applications --display folder
dockutil --no-restart --add ~/development --display folder
dockutil --add ~/Downloads

killall Dock

echo 'Dock configured!'