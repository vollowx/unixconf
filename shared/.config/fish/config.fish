set fish_greeting

fish_vi_key_bindings
set -g fish_vi_force_cursor
set -g fish_cursor_default block
set -g fish_cursor_insert underscore
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

starship init fish | source
zoxide init fish | source

alias cp='cp -r'
alias rm='rm -r'
alias mkdir='mkdir -p'

alias :h='man'
alias :q='exit'

alias gb='git branch'
alias gc='git commit'
alias gca='git commit --all'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gpl='git pull'
alias gp='git push'
alias gpf='git push --force'
alias ls='eza --sort type --git'
alias la='ls -a'
alias ll='ls --long'
alias lla='ll -a'
alias top='htop'
alias vi='nvim'
alias vim='nvim'
