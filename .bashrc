# This is a modified .bashrc file from Charged as a part of Charged3-Gaps.
# If you face any issues, contact us on GitLab!

# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='lsd -l'
alias ll='lsd -la'
PS1='[\u@\h \W]\$ '

export XDG_DATA_HOME="/home/charged/.local/share"
export XDG_CONFIG_HOME="/home/charged/.config"
export XDG_STATE_HOME="/home/charged/.local/state"
export XDG_CACHE_HOME="/home/charged/.cache"

eval "$(starship init bash)"

# XDG
export HISTFILE="$XDG_STATE_HOME"/bash/history
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
# export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export ZDOTDIR="$HOME"/.config/zsh

colorscript random
# neofetch
# cowsay putsomethinghere

####################
## CUSTOM ALIASES ##
####################

# Misc Aliases
alias colourscript=colorscript
alias shell="echo $SHELL"
alias show="clear && colourscript random"

# Suckless
alias cld="rm config.def.h.rej config.def.h.orig dwm.1.rej dwm.c.rej config.h"
alias cldm="rm config.def.h.rej dmenu.c.orig config.h"
alias clds="rm config.def.h.rej st.c.orig config.h"
alias st="st -z 18"

# Emacs aliases
alias doom="~/.emacs.d/bin/doom"
alias ecli="emacs -nw"

# List
alias ls="lsd -l"
alias ll="lsd -Alh"

# XMonad
alias xrc="xmonad --recompile; xmonad --restart"

# Devour
alias dv="devour"
alias mpv="devour mpv"
alias librewolf="devour librewolf"
alias vlc="devour vlc"

# Server Aliases
alias server="sh ~/server"
# alias nug = "sh ~/nugserver"

# Package aliases
alias install="paru -S"
alias uninstall="paru -Rsn"
alias remove="paru -Rsn"
alias update="paru && flatpak update"
alias fixkey="paru -Sy archlinux-keyring && paru"
alias lspkg="LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h"

# Nvim configs
alias i3config="nvim ~/.config/i3/config"
alias fish-config="nvim ~/.config/fish/config.fish"
alias qtc="emacs ~/.config/qtile/config.py"
alias qtileconf="nvim ~/.config/qtile/config.py"

# Git
alias addall="git add ."
alias gitrm="git restore --staged"
alias commit="git commit -m"
alias push="git push"

# Packaging
alias update-repo="repo-add chde-repo.db.tar.gz *.pkg.tar.zst"
alias clean="rm -rf chde-configs/ pkg src"
alias rn="rm chde-repo.db chde-repo.files;mv chde-repo.db.tar.gz chde-repo.db; mv chde-repo.files.tar.gz chde-repo.files"

# Dotfiles
alias d="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias dls="config ls-tree --full-tree -r --name-only HEAD"
alias da="d add -u"
alias dc="d commit -m"
alias dp="d push; d push codeberg; d push github"
alias ds="d status"
alias drm="d restore --staged"
alias cysinfoo=cysinfo
alias cysinfooo="cysinfo"
alias cysinfo_online="curl -s https://gitlab.com/charged1/cysinfo/-/raw/main/cysinfo.sh | bash"
