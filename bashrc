## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi

############################################################
## PATH
############################################################

function conditionally_prefix_path {
  local dir=$1
  if [ -d $dir ]; then
    PATH="$dir:${PATH}"
  fi
}

conditionally_prefix_path /usr/local/bin/git
#conditionally_prefix_path /usr/local/heroku/bin ### Added by the Heroku Toolbelt
conditionally_prefix_path /Applications/Postgres.app/Contents/Versions/latest/bin/

conditionally_prefix_path $HOME/.rvm/bin # Add RVM to PATH for scripting

#conditionally_prefix_path /usr/local/bin
#conditionally_prefix_path /usr/local/sbin
#conditionally_prefix_path /usr/local/share/npm/bin
#conditionally_prefix_path /usr/local/mysql/bin
#conditionally_prefix_path /usr/local/heroku/bin
#conditionally_prefix_path /usr/texbin
#conditionally_prefix_path ~/bin
#conditionally_prefix_path ~/bin/private

PATH=.:./bin:${PATH}
PATH=.:./node_modules/.bin:${PATH}

############################################################
## MANPATH
############################################################

function conditionally_prefix_manpath {
  local dir=$1
  if [ -d $dir ]; then
    MANPATH="$dir:${MANPATH}"
  fi
}

conditionally_prefix_manpath /usr/local/man
#conditionally_prefix_manpath ~/man

############################################################
## Other paths
############################################################

function conditionally_prefix_cdpath {
  local dir=$1
  if [ -d $dir ]; then
    CDPATH="$dir:${CDPATH}"
  fi
}

conditionally_prefix_cdpath ~/Code


CDPATH=.:${CDPATH}

# Set INFOPATH so it includes users' private info if it exists
# if [ -d ~/info ]; then
#   INFOPATH="~/info:${INFOPATH}"
# fi

############################################################
## General development configurations
###########################################################

export NVM_DIR=$HOME/.nvm
if [ -f $NVM_DIR/nvm.sh ]; then
  . $NVM_DIR/nvm.sh
fi

export PGUSER='postgres'
export NW_PATH=~/Code/nwjs-sdk-v0.15.4-osx-x64/nwjs.app/Contents/MacOS/nwjs

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


############################################################
## Terminal behavior
############################################################

# Possibly fixes colors not displaying in screen and emacs export
TERM=xterm-256color export TERMCAP= # ------------

# Change the window title of X terminals
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac

# Show the git branch and dirty state in the prompt.
function parse_git_dirty {
  [[ -n $(git status -s 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

if [ `which git 2> /dev/null` ]; then
  function git_prompt {
    echo $(parse_git_branch)$(parse_git_dirty)
  }
else
  function git_prompt {
    echo ""
  }
fi

if [ `which rbenv 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(rbenv version-name)
  }
elif [ `which ruby 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(ruby --version | cut -d' ' -f2)
  }
else
  function ruby_prompt {
    echo ""
  }
fi

if [ `which rbenv-gemset 2> /dev/null` ]; then
  function gemset_prompt {
    local gemset=$(rbenv gemset active 2> /dev/null)
    if [ $gemset ]; then
      echo " ${gemset}"
    fi
  }
else
  function gemset_prompt {
    echo ""
  }
fi


if [ -n "$BASH" ]; then
    export PS1="\[$(tput bold)\]\[$(tput setaf 4)\]\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]\[$(tput setaf 2)\]\W\[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"
fi

############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
#shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
#export EDITOR="emacsclient -nw"
export EDITOR="emacs"

############################################################
## History
############################################################

# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend

#export HISTIGNORE="&:p:exit"
# remove duplicates from the history (when a new item is added)
export HISTCONTROL=erasedups
# increase the default size from only 1,000 items

export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history

promptFunc() {
  # right before prompting for the next command, save the previous
  # command in a file.
  echo -e "$(gdate --rfc-2822)\t$(gdate +%s)\t$PWD\t$(history 1 | sed -E 's/^[ ]*[0-9]+[ ]*//')" >> ~/dotfiles/shell_history
}
PROMPT_COMMAND=promptFunc


############################################################
## Aliases
############################################################

if [ -e ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

############################################################
## Bash Completion, if available
############################################################

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
elif  [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif  [ -f /etc/profile.d/bash_completion ]; then
  . /etc/profile.d/bash_completion
elif [ -e ~/.bash_completion ]; then
  # Fallback. This should be sourced by the above scripts.
  . ~/.bash_completion
fi

############################################################
## Other
############################################################

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

# Make sure this appears even after rbenv, git-prompt and other shell extensions
# that manipulate the prompt.
if [ `which direnv 2> /dev/null` ]; then
  eval "$(direnv hook bash)"
fi

############################################################
## Ruby Performance Boost (see https://gist.github.com/1688857)
############################################################

# export RUBY_GC_MALLOC_LIMIT=60000000
# # export RUBY_FREE_MIN=200000 # Ruby <= 2.0
# export RUBY_GC_HEAP_FREE_SLOTS=200000 # Ruby >= 2.1

export PATH="$HOME/.yarn/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
