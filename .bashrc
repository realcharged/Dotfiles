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
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export ZDOTDIR="$HOME"/.config/zsh


colorscript random
# neofetch
# cowsay putsomethinghere
