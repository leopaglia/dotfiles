#!/usr/bin/env bash

# exit on error (non-true return value)
set -e

echo "Please enter root password"
sudo echo "Ok"

# command line developer tools
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
PROD=$(softwareupdate -l |
  grep "\*.*Command Line.*$(sw_vers -productVersion|awk -F. '{print $1"."$2}')" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
softwareupdate -i "$PROD" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# brew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update
brew upgrade

# gnu utils
brew install coreutils
brew install findutils
brew install gnu-tar
brew install gnu-sed
brew install gawk
brew install gnutls
brew install gnu-indent
brew install gnu-getopt
brew install grep

# might replace this for individual aliases for granularity
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

brew install bat
brew install thefuck
brew install neovim
brew install fzf

brew install --cask ferdi
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask docker

brew cleanup

# ohmyzsh
echo 'Installing Oh my zsh!'

[[ ! -d ~/.oh-my-zsh ]] && curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended

export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# powerlevel10k
echo 'Installing Powerlevel10K'

[[ ! -d $ZSH_CUSTOM/themes/powerlevel10k ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# ohmyzsh plugins
echo 'Installing Oh my zsh plugins'

[[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
[[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]] && git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# nvim plugins
echo 'Downloading vim plug'

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | bash

# nvm
echo 'Installing nvm'

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# sdkman
echo 'Installing sdkman'

curl -s "https://get.sdkman.io" | bash

# barrier
echo 'Installing barrier'

curl -fLo ~/Downloads/barrier.dmg https://github.com/debauchee/barrier/releases/download/v2.4.0/Barrier-2.4.0-release.dmg
sudo hdiutil attach ~/Downloads/barrier.dmg
sudo cp -R /Volumes/barrier/Barrier.app /Applications
sudo hdiutil unmount /Volumes/barrier/Barrier.app

openssl req -x509 -nodes -days 365 -subj /CN=Barrier -newkey rsa:4096 -keyout ~/Library/Application Support/barrier/SSLBarrier.pem -out ~/Library/Application Support/barrier/SSLBarrier.pem

# create SSH key pair without prompts (all default)
# https://stackoverflow.com/a/43235320/4847712
echo 'Creating SSH key'

ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1

echo "PUBLIC KEY:"

# display on screen
cat ~/.ssh/id_rsa.pub
# copy to clipboard
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

echo "All set! Press any key to quit." -n1 -s

killall Terminal
