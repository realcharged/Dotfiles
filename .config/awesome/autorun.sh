#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run "picom"
run "volumeicon"
run "xfce4-clipman"
run "nm-applet"
run "nitrogen --restore"
run "mpv --no-video ~/Music/startup.mp3"
run "emacs --daemon"
run "lxsession"