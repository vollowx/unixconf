set fish_greeting

cat ~/.profile | source
starship init fish | source
zoxide init fish | source

set fish_greeting

alias cp='cp -r'
alias rm='rm -rf'
alias mkdir='mkdir -p'

alias :h='man'
alias :q='exit'

alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --all'
alias gcl='git clone'
alias gd='git diff'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gpl='git pull'
alias gp='git push'
alias gpf='git push --force'

alias cat='bat'
alias du='dust'
alias ls='eza --sort type --git'
alias la='ls -a'
alias ll='ls --long'
alias lla='ll -a'
alias top='htop'
alias vi='nvim'
alias lz='lazygit'

# [ $(tty) = '/dev/tty1' ] && exec wayfire
