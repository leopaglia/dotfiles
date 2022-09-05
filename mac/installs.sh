#!/bin/bash

# cli dev tools
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

brew install coreutils
brew install findutils
brew install gnu-tar
brew install gnu-sed
brew install gawk
brew install gnutls
brew install gnu-indent
brew install gnu-getopt
brew install grep

export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

brew install bat
brew install thefuck
brew install neovim
brew install fzf
brew install htop

brew install --cask ferdi
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask docker

brew cleanup

# ohmyzsh
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

[[ ! -d ~/.oh-my-zsh ]] && curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended
[[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
[[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]] && git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
[[ ! -d $ZSH_CUSTOM/themes/powerlevel10k ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# vim plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | bash

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# sdkman
curl -s "https://get.sdkman.io" | bash

# barrier
curl -fLo ~/Downloads/barrier.dmg https://github.com/debauchee/barrier/releases/download/v2.4.0/Barrier-2.4.0-release.dmg
sudo hdiutil attach ~/Downloads/barrier.dmg
sudo cp -R /Volumes/barrier/Barrier.app /Applications
sudo hdiutil unmount /Volumes/barrier/Barrier.app

openssl req -x509 -nodes -days 365 -subj /CN=Barrier -newkey rsa:4096 -keyout ~/Library/Application\ Support/barrierSSLBarrier.pem -out ~/Library/Application\ Support/barrierSSLBarrier.pem
