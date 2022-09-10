# This is a modified .bashrc file from Charged as a part of Charged3-Gaps.
# If you face any issues, contact us on GitLab!

# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='lsd -l'
alias ll='lsd -la'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
export HISTFILE="${XDG_STATE_HOME}"/bash/history

colorscript random
# neofetch
# cowsay putsomethinghere
