# Hide fish greeting
set fish_greeting

# Set GPG_TTY for GnuPG signing
set -Ux GPG_TTY (tty)

if status is-interactive
    # Starship prompt
    # source ("/usr/bin/starship" init fish --print-full-init | psub)
    source ("/usr/local/bin/starship" init fish --print-full-init | psub)
    # Run neofetch on interactive shell startup
#    if type -q neofetch
#        neofetch
#    end
end

# Replace ls with exa
alias ls='exa -abl --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'   # all failes and dirs
alias ll='exa -bl --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons'  # tree listing
alias l.="exa -a | egrep '^\.'"                                      # show only dotfiles

# Nuke reboot
alias reboot='echo "never"'

# Misc aliases
alias wget='aria2c'
alias gp='git push'
alias gcl='git clone'
alias gpl='git pull'

# Replace cat with bat
alias cat='bat --style=changes,header,rule,numbers,snip'
