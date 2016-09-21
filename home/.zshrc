#Path to your oh-my-zsh installation.
DEFAULT_USER=timhyson

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias rake="noglob rake"

# Mac Helpers
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

# SICP Racket Bullshit
alias racket="racket -i -p neil/sicp -l xrepl"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(history-substring-search zsh-syntax-highlighting nyan)

export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
# User configuration

export PATH=$PATH:"/usr/local/bin:/usr/local/bin/git:/usr/local/heroku/bin:/Users/timhyson/.rvm/gems/ruby-2.1.1/bin:/Users/timhyson/.rvm/gems/ruby-2.1.1@global/bin:/Users/timhyson/.rvm/rubies/ruby-2.1.1/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/timhyson/.rvm/bin:/usr/local/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
# move /usr/local/bin/git: before /usr/bin:]
export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -"

export EDITOR="/usr/bin/vim"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias cdh='cd ~/.homesick/repos/home-files/home'
alias hup='cdh && sh ~/.homesick/repos/home-files/commit.sh && source ~/.zshrc && cd - && clear'

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#############
# FUNCTIONS
#############

mcd() { # creates a directory and places you in it
  mkdir -p $1
  cd $1
}

# Config for 'z': http://jilles.me/badassify-your-terminal-and-shell/
. `brew --prefix`/etc/profile.d/z.sh
source /usr/local/share/zsh/site-functions

# To link aliases between bash and zsh shells:
source $HOME/.aliases

# Use ctrl-z to return to vim
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

bindkey -v

# By default, word jumps (option + → or ←) do not work. You can make this work
# by adding the following to your ~/.zshrc:
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# Syntax highlighting
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

