#!/usr/bin/env bash

# exit on error (non-true return value)
set -e

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until everything has finished
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

echo 'Updating system configurations'
source ./mac/system.sh

echo 'Configuring Dock'
source ./mac/dock.sh

echo 'Installing apps'
source ./mac/installs.sh

# create SSH key pair without prompts (all default)
# https://stackoverflow.com/a/43235320/4847712
echo 'Creating SSH key'
ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1

echo "PUBLIC KEY:"
# display and copy to clipboard
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub | pbcopy

# prompt and wait for keypress
read -p "The public key has been copied to clipboard. Add it to github and press any key to continue..." -n1 -s

# create development folder
echo 'Creating dev directory'
[[ ! -d ~/development ]] && mkdir ~/development

echo 'Cloning dotfiles project'

DOTFILES_REPO_LOCATION=~/development/dotfiles
git clone git@github.com:leopaglia/dotfiles.git "$DOTFILES_REPO_LOCATION"

echo 'Symlinking config files'

# gnu cp -- has recursive symlinking
gcp -rsf "$DOTFILES_REPO_LOCATION/dotfiles"/. ~

# install nvim plugins
echo 'Installing neovim plugins'
vim -es -u ~/.config/nvim/init.vim +PlugInstall +qa

# TODO
echo "Run p10k configure manually after restarting the terminal to install missing fonts."

echo "All set! Press any key to quit." -n1 -s

killall Terminal
