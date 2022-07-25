#!bin/bash

# exit on error (non-true return value)
set -e

echo "Please enter root password"
sudo echo "Ok"

# command line developer tools
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line.*$(sw_vers -productVersion|awk -F. '{print $1"."$2}')" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
softwareupdate -i "$PROD" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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

brew install wget --with-iri

brew install bat
brew install thefuck
brew install neovim
brew install fzf
$(brew --prefix)/opt/fzf/install

brew install --cask iterm2
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask docker

brew cleanup

# ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

export ZSH_CUSTOM = $HOME/.ohmyzsh/custom

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# ohmyzsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# nvim plugins
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install nvim plugins
vim -es -u ~/.config/nvim/init.vim +PlugInstall +qa\

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# sdkman
curl -s "https://get.sdkman.io" | bash

# barrier
curl -o ~/Downloads/barrier.dmg https://github.com/debauchee/barrier/releases/download/v2.4.0/Barrier-2.4.0-release.dmg
sudo hdiutil attach ~/Downloads/barrier.dmg
sudo cp -R /Volumes/barrier/Barrier.app /Applications
sudo hdiutil unmount /Volumes/barrier/Barrier.app

# create SSH key pair without prompts (all default)
# https://stackoverflow.com/a/43235320/4847712
ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1

echo "\n\n PUBLIC KEY:"

cat ~/.ssh/id_rsa.pub

echo "\n\n"

# prompt and wait for keypress
read -p "Add the SSH public key to github and press any key to continue...\n" -n1 -s

# create development folder
mkdir ~/development

DOTFILES_REPO_LOCATION=~/development/dotfiles

git clone git@github.com:leopaglia/dotfiles.git "$DOTFILES_REPO_LOCATION"

cp -rsf "$DOTFILES_REPO_LOCATION/home"/. ~
