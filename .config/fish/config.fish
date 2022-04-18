source ~/.fish_extras

# Hide fish greeting
set fish_greeting

# Set GPG_TTY for GnuPG signing
set -Ux GPG_TTY (tty)

#if status is-interactive
    # Starship prompt
    # source ("/usr/bin/starship" init fish --print-full-init | psub)
#    source ("/usr/local/bin/starship" init fish --print-full-init | psub)
    # Run neofetch on interactive shell startup
#    if type -q neofetch
#        neofetch
#    end
#    true
#end

# Replace ls with exa
alias ls='exa -abl --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'   # all failes and dirs
alias ll='exa -bl --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons'  # tree listing
alias l.="exa -a | egrep '^\.'"                                      # show only dotfiles

# Nuke reboot
alias reboot='echo "never"'
#thefuck --alias | source

# Misc aliases
alias wget='aria2c'
alias gp='git push'
alias gcl='git clone'
alias gpl='git pull'
alias tb='nc termbin.com 9999; :'
alias reload='source ~/.config/fish/config.fish'

# Source common aliases
source ~/.aliasrc

# Replace cat with bat
alias cat='bat --style=changes,header,rule,numbers,snip --wrap=never'

#thefuck --alias | source
#test -d ~/.gdrive-downloader && begin; set PATH $HOME/.gdrive-downloader:$PATH; export PATH; end
#set -g PATH $HOME/.cargo/bin:/$HOME/bin:$HOME/.local/bin:$PATH
#export PATH
