# Main file for fish command completions. This file contains various
# common helper functions for the command completions. All actual
# completions are located in the completions subdirectory.
#
# Set default field separators
#
set -g IFS \n\ \t
set -qg __fish_added_user_paths
or set -g __fish_added_user_paths

# For one-off upgrades of the fish version, see __fish_config_interactive.fish
if not set -q __fish_initialized
    set -U __fish_initialized 0
    if set -q __fish_init_2_39_8
        set __fish_initialized 2398
    else if set -q __fish_init_2_3_0
        set __fish_initialized 2300
    end
end

#
# Create the default command_not_found handler
#
function __fish_default_command_not_found_handler
    printf "fish: Unknown command: %s\n" (string escape -- $argv[1]) >&2
end

if not status --is-interactive
    # Hook up the default as the command_not_found handler
    # if we are not interactive to avoid custom handlers.
    function fish_command_not_found --on-event fish_command_not_found
        __fish_default_command_not_found_handler $argv
    end
end

#
# Set default search paths for completions and shellscript functions
# unless they already exist
#

# __fish_data_dir, __fish_sysconf_dir, __fish_help_dir, __fish_bin_dir
# are expected to have been set up by read_init from fish.cpp

# Grab extra directories (as specified by the build process, usually for
# third-party packages to ship completions &c.
set -l __extra_completionsdir
set -l __extra_functionsdir
set -l __extra_confdir
if test -f $__fish_data_dir/__fish_build_paths.fish
    source $__fish_data_dir/__fish_build_paths.fish
end

# Compute the directories for vendor configuration.  We want to include
# all of XDG_DATA_DIRS, as well as the __extra_* dirs defined above.
set -l xdg_data_dirs
if set -q XDG_DATA_DIRS
    set --path xdg_data_dirs $XDG_DATA_DIRS
    set xdg_data_dirs (string replace -r '([^/])/$' '$1' -- $xdg_data_dirs)/fish
else
    set xdg_data_dirs $__fish_data_dir
end

set -l vendor_completionsdirs
set -l vendor_functionsdirs
set -l vendor_confdirs
# Don't load vendor directories when running unit tests
if not set -q FISH_UNIT_TESTS_RUNNING
    set vendor_completionsdirs $xdg_data_dirs/vendor_completions.d
    set vendor_functionsdirs $xdg_data_dirs/vendor_functions.d
    set vendor_confdirs $xdg_data_dirs/vendor_conf.d

    # Ensure that extra directories are always included.
    if not contains -- $__extra_completionsdir $vendor_completionsdirs
        set -a vendor_completionsdirs $__extra_completionsdir
    end
    if not contains -- $__extra_functionsdir $vendor_functionsdirs
        set -a vendor_functionsdirs $__extra_functionsdir
    end
    if not contains -- $__extra_confdir $vendor_confdirs
        set -a vendor_confdirs $__extra_confdir
    end
end

# Set up function and completion paths. Make sure that the fish
# default functions/completions are included in the respective path.

if not set -q fish_function_path
    set fish_function_path $__fish_config_dir/functions $__fish_sysconf_dir/functions $vendor_functionsdirs $__fish_data_dir/functions
else if not contains -- $__fish_data_dir/functions $fish_function_path
    set -a fish_function_path $__fish_data_dir/functions
end

if not set -q fish_complete_path
    set fish_complete_path $__fish_config_dir/completions $__fish_sysconf_dir/completions $vendor_completionsdirs $__fish_data_dir/completions $__fish_user_data_dir/generated_completions
else if not contains -- $__fish_data_dir/completions $fish_complete_path
    set -a fish_complete_path $__fish_data_dir/completions
end

# Add a handler for when fish_user_path changes, so we can apply the same changes to PATH
function __fish_reconstruct_path -d "Update PATH when fish_user_paths changes" --on-variable fish_user_paths
    # Deduplicate $fish_user_paths
    # This should help with people appending to it in config.fish
    set -l new_user_path
    for path in (string split : -- $fish_user_paths)
        if not contains -- $path $new_user_path
            set -a new_user_path $path
        end
    end

    if test (count $new_user_path) -lt (count $fish_user_paths)
        # This will end up calling us again, so we return
        set fish_user_paths $new_user_path
        return
    end

    set -l local_path $PATH

    for x in $__fish_added_user_paths
        set -l idx (contains --index -- $x $local_path)
        and set -e local_path[$idx]
    end

    set -g __fish_added_user_paths
    if set -q fish_user_paths
        # Explicitly split on ":" because $fish_user_paths might not be a path variable,
        # but $PATH definitely is.
        for x in (string split ":" -- $fish_user_paths[-1..1])
            if set -l idx (contains --index -- $x $local_path)
                set -e local_path[$idx]
            else
                set -ga __fish_added_user_paths $x
            end
            set -p local_path $x
        end
    end

    set -xg PATH $local_path
end

#
# Launch debugger on SIGTRAP
#
function fish_sigtrap_handler --on-signal TRAP --no-scope-shadowing --description "TRAP handler: debug prompt"
    breakpoint
end

#
# When a prompt is first displayed, make sure that interactive
# mode-specific initializations have been performed.
# This handler removes itself after it is first called.
#
function __fish_on_interactive --on-event fish_prompt
    __fish_config_interactive
    functions -e __fish_on_interactive
end

# Set the locale if it isn't explicitly set. Allowing the lack of locale env vars to imply the
# C/POSIX locale causes too many problems. Do this before reading the snippets because they might be
# in UTF-8 (with non-ASCII characters).
__fish_set_locale

# Upgrade pre-existing abbreviations from the old "key=value" to the new "key value" syntax.
# This needs to be in share/config.fish because __fish_config_interactive is called after sourcing
# config.fish, which might contain abbr calls.
if test $__fish_initialized -lt 2300
    if set -q fish_user_abbreviations
        set -l fab
        for abbr in $fish_user_abbreviations
            set -a fab (string replace -r '^([^ =]+)=(.*)$' '$1 $2' -- $abbr)
        end
        set fish_user_abbreviations $fab
    end
end

#
# Some things should only be done for login terminals
# This used to be in etc/config.fish - keep it here to keep the semantics
#
if status --is-login
    if command -sq /usr/libexec/path_helper
        # Adapt construct_path from the macOS /usr/libexec/path_helper
        # executable for fish; see
        # https://opensource.apple.com/source/shell_cmds/shell_cmds-203/path_helper/path_helper.c.auto.html .
        function __fish_macos_set_env -d "set an environment variable like path_helper does (macOS only)"
            set -l result

            # Populate path according to config files
            for path_file in $argv[2] $argv[3]/*
                if test -f $path_file
                    while read -l entry
                        if not contains -- $entry $result
                            test -n "$entry"
                            and set -a result $entry
                        end
                    end <$path_file
                end
            end

            # Merge in any existing path elements
            for existing_entry in $$argv[1]
                if not contains -- $existing_entry $result
                    set -a result $existing_entry
                end
            end

            set -xg $argv[1] $result
        end

        __fish_macos_set_env PATH /etc/paths '/etc/paths.d'
        if test -n "$MANPATH"
            __fish_macos_set_env MANPATH /etc/manpaths '/etc/manpaths.d'
        end
        functions -e __fish_macos_set_env
    end

    #
    # Put linux consoles in unicode mode.
    #
    if test "$TERM" = linux
        and string match -qir '\.UTF' -- $LANG
        and command -sq unicode_start
        unicode_start
    end
end

# Invoke this here to apply the current value of fish_user_path after
# PATH is possibly set above.
__fish_reconstruct_path

# Allow %n job expansion to be used with fg/bg/wait
# `jobs` is the only one that natively supports job expansion
function __fish_expand_pid_args
    for arg in $argv
        if string match -qr '^%\d+$' -- $arg
            if not jobs -p $arg
                return 1
            end
        else
            printf "%s\n" $arg
        end
    end
end

for jobbltn in bg wait disown
    function $jobbltn -V jobbltn
        builtin $jobbltn (__fish_expand_pid_args $argv)
    end
end
function fg
    builtin fg (__fish_expand_pid_args $argv)[-1]
end

function kill
    command kill (__fish_expand_pid_args $argv)
end

# As last part of initialization, source the conf directories.
# Implement precedence (User > Admin > Extra (e.g. vendors) > Fish) by basically doing "basename".
set -l sourcelist
for file in $__fish_config_dir/conf.d/*.fish $__fish_sysconf_dir/conf.d/*.fish $vendor_confdirs/*.fish
    set -l basename (string replace -r '^.*/' '' -- $file)
    contains -- $basename $sourcelist
    and continue
    set sourcelist $sourcelist $basename
    # Also skip non-files or unreadable files.
    # This allows one to use e.g. symlinks to /dev/null to "mask" something (like in systemd).
    test -f $file -a -r $file
    and source $file
end

# Things not set
set XDG_DATA_HOME "/home/charged/.local/share"
set XDG_CONFIG_HOME "/home/charged/.config"
set XDG_STATE_HOME "/home/charged/.local/state"
set XDG_CACHE_HOME "/home/charged/.cache"

# XDG
export HISTFILE="$XDG_STATE_HOME"/bash/history
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
# export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export ZDOTDIR="$HOME"/.config/zsh

# CHDE REPO DIRECTORY
set REPODIR "/home/charged/CHDE/chde-repo/x86_64/"

#####################################
########## CUSTOM STARTUPS ##########
#####################################

colorscript random
set fish_greeting
starship init fish | source

####################################
########## CUSTOM ALIASES ##########
####################################

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
