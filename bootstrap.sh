#!bin/bash

brew update
brew upgrade

brew install wget --with-iri

brew install bat
brew install thefuck
brew install neovim
brew install fzf
$(brew --prefix)/opt/fzf/install

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

# create development folder
mkdir ~/development
