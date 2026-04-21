# HomeBrew
eval (/opt/homebrew/bin/brew shellenv)

if type -q gpgconf
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end

# Fish Paths
set fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings

# Paths
fish_add_path /bin
fish_add_path ~/.local/bin
fish_add_path ~/go/bin
fish_config theme choose reverse_void

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Key Bindings
bind -M insert ctrl-o nvim
bind ctrl-o nvim
bind -M insert ctrl-\\ rmpc
bind ctrl-\\ rmpc
bind -M insert ctrl-f fzf-file-widget
bind ctrl-f fzf-cd-widget
bind -M insert ctrl-m _sesh_connect
bind ctrl-m _sesh_connect

# Global variables
set -gx LANG ru_RU.UTF-8
set -gx EZA_CONFIG_DIR ~/.config/eza
set -Ux MANPAGER "nvim +Man!"
set -x LESSHISTFILE "-"
set -Ux GPG_TTY (tty)
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -gx XDG_CONFIG_HOME ~/.config
set -gx BAT_THEME "reverse-void"
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/go/bin $PATH
set -gx GOPATH (go env GOPATH)
set -gx GOBIN $GOPATH/bin
set -gx PATH $PATH $GOBIN
set -x  PATH $HOME/.local/share/solana/install/active_release/bin $PATH

# |====== Aliases  ======|
alias vim nvim
alias v nvim
alias c clear
alias :q exit

# |====== Git  ======|
alias g "git"
alias gs "git status -s"
alias gc "git clone"
alias glog "git log --oneline --graph --all"

# |====== Utils  ======|
alias cp "cp -i"
alias dow "z ~/Downloads"
alias doc "z ~/Documents"
alias h history
alias attach "tmux attach"
alias mpds "mpd ~/.config/mpd/mpd.conf"

# |======  CD  ======|
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

# |======  LS  ======|
alias l "eza -l --icons --git -a"
alias ls "eza"
alias ll "eza --tree --level=2 --long --icons --git"
alias e "eza --long --tree"
alias lt "eza -lAh --icons=always --git --tree --level=4 --long --ignore-glob='node_modules|.git' "

# |======  Config App  ======|
alias nrc "cd ~/.config/nvim | vim "
alias trc "cd ~/.config/tmux | vim "
alias frc "vim ~/.config/fish/config.fish"
alias gnrc "cd ~/.gnupg/"
alias grc "vim ~/.config/ghostty/config"
alias arc "vim ~/.config/aerospace/aerospace.toml"
alias u "source ~/.config/fish/config.fish"
alias gu "gpgconf --kill gpg-agent &&  gpgconf --launch gpg-agent"

# |======  Applications  ======|
alias ff "fastfetch"
alias cat bat
alias lg lazygit
alias code code-insiders


# |======  Custom  ======|
alias live 'live-server --port=5500 --wait=50 --ignore="**/*.scss,**/*.sass,**/*.ts,.vscode/**"'
alias trs "tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | xargs -I {} tmux send-keys -t {} 'source ~/.config/fish/config.fish' Enter"
alias trf "tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | xargs -I {} tmux send-keys -t {} 'exec fish' Enter"
# alias trf "tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | awk '$2 ~ /fish|bash|zsh/ {print $1}' | xargs -I {} tmux send-keys -t {} 'exec fish' Enter"

# |======  HomeBrew ======|
alias bi "brew install"
alias bs "brew search"

# FZF default command
set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"

# FZF default opts with vague colors
# set -gx FZF_DEFAULT_OPTS "\
#   --tmux 90%,85%\
#   --style full \
#   --color=bg:-1,bg+:#1e1e22,fg:#90a0b5,fg+:#f3be7c \
#   --color=hl:#d8647e,hl+:#d8647e,border:#606079,label:#aeaed1 \
#   --color=prompt:#b4d4cf,pointer:#f3be7c,marker:#7fa563,spinner:#bb9dbd"

# FZF default opts with reverse_void colors
set -gx FZF_DEFAULT_OPTS "\
  --tmux 90%,85%\
  --style full \
  --color=bg:-1,bg+:#B2B2B3,fg:#4C465D,fg+:#1F1F1F \
  --color=hl:#D73A49,hl+:#D73A49,border:#5E6F8E,label:#6B6B6B \
  --color=prompt:#D73A49,pointer:#1F1F1F,marker:#063970,spinner:#6B6B6B"

function _sesh_connect
    set session (sesh list -c -t | fzf)
    if test -n "$session"
        sesh connect $session
    end
end

function delx
    set files (find . -maxdepth 1 -type f -perm +111)

    if test (count $files) -eq 0
        echo "No executables found."
        return
    end

    echo "Executables found:"
    for f in $files
        echo " - $f"
    end

    # Correct fish prompt flag (uppercase -P)
    read -l -P "Delete these files? (y/N): " confirm

    if test "$confirm" = "y"
        rm $files
        echo "Deleted."
    else
        echo "Aborted."
    end
end

function f
    set selected (fd --type d --hidden \
        --exclude .git \
        --exclude node_modules \
        --exclude target \
        --exclude .venv \
        --exclude venv \
        --exclude __pycache__ \
        --exclude dist \
        --exclude build \
        --exclude .idea \
        --exclude .vscode \
        . ~/dev | \
        grep -i "$argv[1]" | \
        sed "s|$HOME/dev/||" | \
        fzf --select-1 --exit-0 --tmux 75%,80%)
    if test -n "$selected"
        cd "$HOME/dev/$selected"
    else
        echo "No folder selected"
    end
end

function o
    set selected (fd --type f --hidden \
        --exclude .git \
        --exclude node_modules \
        --exclude target \
        --exclude .venv \
        --exclude venv \
        --exclude __pycache__ \
        --exclude dist \
        --exclude build \
        --exclude .idea \
        --exclude .vscode \
        --exclude "*.pyc" \
        --exclude "*.lock" \
        --exclude "*.min.js" \
        --exclude "*.min.css" \
        --exclude "*.map" \
        --exclude ".DS_Store" \
        . ~/dev | \
        grep -i "$argv[1]" | \
        sed "s|$HOME/dev/||" | \
        fzf --select-1 --exit-0 \
            --preview 'bat --color=always --style=numbers ~/dev/{}' \
            --preview-window 'right:55%:border-left')
    if test -n "$selected"
        nvim "$HOME/dev/$selected"
    else
        echo "No file selected"
    end
end

function s
    set selected (fd --type f --hidden \
        --exclude .git \
        --exclude node_modules \
        --exclude target \
        --exclude .venv \
        --exclude venv \
        --exclude __pycache__ \
        --exclude dist \
        --exclude build \
        --exclude .idea \
        --exclude .vscode \
        --exclude "*.pyc" \
        --exclude "*.lock" \
        --exclude "*.min.js" \
        --exclude "*.min.css" \
        --exclude "*.map" \
        --exclude ".DS_Store" \
        . | \
        grep -i "$argv[1]" | \
        sed 's|^\./||' | \
        fzf --select-1 --exit-0 \
            --preview 'bat --color=always --style=numbers {}' \
            --preview-window 'right:55%:border-left')
    if test -n "$selected"
        nvim $selected
    else
        echo "No file selected"
    end
end

function p
    set selected (fd --type f --hidden \
        -e png -e jpg -e jpeg -e gif -e tiff -e bmp -e heic -e webp -e svg -e ico \
        -e pdf -e ai -e eps -e ps \
        -e cr2 -e nef -e arw \
        . | \
        grep -i "$argv[1]" | \
        sed 's|^\./||' | \
        fzf --select-1 --exit-0 --no-preview --tmux 75%,80%)
    if test -n "$selected"
        open -a "Preview" $selected
    else
        echo "No file selected"
    end
end

# source
starship init fish | source
zoxide init fish | source
fzf --fish | source
status --is-interactive; and rbenv init - fish | source
