# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant promp. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%)-%n}.zsh}" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%)-%n}.zsh}"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# update automatically without asking every 5 days
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 5

# display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# history command output stamp format
HIST_STAMPS="mm-dd-yyyy"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions npm nvm thefuck vscode zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

# aliases
alias ccat="/bin/cat"
alias cat="bat"
alias vim="nvim"

# remove git cherry-pick alias (collides with GNU's copy)
unalias gcp 

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# default directory
if [[ $PWD == $HOME ]]; then
  cd ~/development
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

