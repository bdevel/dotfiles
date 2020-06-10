#!/bin/bash
# Adds an alias to the current shell and to this file.
# Borrowed from Mislav (http://github.com/mislav/dotfiles/tree/master/bash_aliases)
add-alias ()
{
   local name=$1 value=$2
   echo "alias $name='$value'" >> ~/.bash_aliases
   eval "alias $name='$value'"
   alias $name
}

############################################################
## Bash
############################################################

# alias cd..="cd .."
alias ..="cd ..; ls"
alias ...="cd ../../; ls"
alias ....="cd ../../../; ls"
# alias .2="cd ../../"
# alias .3="cd ../../../"
# alias .4="cd ../../../../"
# alias .5="cd ../../../../../"
# alias ~="cd ~"
#alias c="clear"

alias path='echo -e ${PATH//:/\\n}'
alias ax="chmod a+x"

############################################################
## List
############################################################

if [[ `uname` == 'Darwin' ]]; then
  alias ls="ls -G"
  # good for dark backgrounds
  export LSCOLORS=gxfxcxdxbxegedabagacad
else
  alias ls="ls --color=auto"
  # good for dark backgrounds
  export LS_COLORS='no=00:fi=00:di=00;36:ln=00;35:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;31:'
  # For LS_COLORS template: $ dircolors /etc/DIR_COLORS
fi

alias cde='cd ~/dotfiles/emacs.d'
alias cdd='cd ~/dotfiles'
alias cdc='clear; cd ~/Code; ls'
alias cdim="clear; cd ~/Code/ist-merlin; git status"
alias cdic="clear; cd ~/Code/ist-client; git status"
alias cdir='clear; cd ~/Code/ist-reliability; git status'

# CD return, save location
alias cdr="d0=\$(pwd); cd"
alias cdr1="d1=\$(pwd); cd"
alias cdr2="d2=\$(pwd); cd"
# CD Back
alias cdb="cd $d0"
alias cdb1="cd $d1"
alias cdb2="cd $d2"



#alias ls='ls -G'
alias l="ls"
alias ll="ls -lh"
alias la="ls -a"
alias lal="ls -alh"



############################################################
## Git
############################################################

alias g='git'
alias ga='git add'
alias gcam='git commit -am'
alias gc='git commit'

alias gco='git checkout'
alias gcom='git checkout master'
alias gcob='git checkout -b'

alias gm='git merge'
alias gfum='git fetch upstream'
alias gmum='git merge upstream/master'
alias gb='git branch'
alias gs='git status'
alias gl='git log'
alias glp='git log -p'
alias gls='git log -s'
alias gd='git diff'
alias gpo='git push'
alias gpu='git push upstream'


# alias g="git"
# alias gb="git branch -a -v"
# alias gc="git commit -v"
# alias gca="git commit -v -a"
# alias gd="git diff"
# alias gl="git pull"
# alias glr="git pull --rebase"
# alias gf="git fetch"
# alias gp="git push"
# alias gs="git status -sb"
# alias gr="git remote"
# alias grp="git remote prune"
# alias gcp="git cherry-pick"
# alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci)%Creset' --abbrev-commit --date=relative"
# alias ggs="gg --stat"
# alias gsl="git shortlog -sn"
# alias gw="git whatchanged"
# alias gsu="git submodule update --init --recursive"
# alias gi="git config branch.master.remote 'origin'; git config branch.master.merge 'refs/heads/master'"
# if [ `which hub 2> /dev/null` ]; then
#   alias git="hub"
# fi
# alias git-churn="git log --pretty="format:" --name-only | grep -vE '^(vendor/|$)' | sort | uniq -c | sort"

############################################################
## OS X
############################################################

# Get rid of those pesky .DS_Store files recursively
alias dstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'
alias ecu='find . | grep ~$ | xargs rm' # clean emacs backup files


# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"


# Show/hide hidden files in Finder
# alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
# alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# # Hide/show all desktop icons (useful when presenting)
# alias showdeskicons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
# alias hidedeskicons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"




############################################################
## Ruby
############################################################

# alias rtags="ctags -e -R app lib vendor tasks"

# function gemdir {
#   echo `gem env gemdir`
# }

# function gemfind {
#   local gems=`gemdir`/gems
#   echo `ls $gems | grep -i $1 | sort | tail -1`
# }

# # Use: gemcd <name>, cd's into your gems directory
# # that best matches the name provided.
# function gemcd {
#   cd `gemdir`/gems/`gemfind $1`
# }

# Use: gemdoc <gem name>, opens the rdoc of the gem
# that best matches the name provided.
function gemdoc {
  open `gemdir`/doc/`gemfind $1`/rdoc/index.html
}

alias rc="rails console"
# alias tg="thor -T | grep" # (rake -T; thor -T) | grep syn
alias rtg="rake -T | grep"

############################################################
## Bundler
############################################################
# function ignore_vendor_ruby {
#   grep -q 'vendor/ruby' .gitignore > /dev/null
#   if [[ $? -ne 0 ]]; then
#     echo -e "\nvendor/ruby" >> .gitignore
#   fi
# }

# alias b="bundle"
# alias bu="b update"
# alias be="b exec"
# alias binit="bi && bundle package"
# alias ba="bundle-audit update && bundle-audit"

# # Bundler v1: Be sure to install https://github.com/rmm5t/rbenv-bundle-path-fix
# # Bundler v2: Be sure to first run: `bundle config --global path vendor`
# function bi {
#   if [ -f ./vendor/cache ]; then
#     b install --local $*
#   else
#     b install $*
#   fi
# }


############################################################
## Docker
############################################################

#alias d="docker"
#alias dc="docker-compose"
#alias dcr="dc run"

############################################################
## Heroku
############################################################

alias hl='heroku local'

#alias deploy_hproduction='hproduction maintenance:on && git push production && hproduction run rake db:migrate && hproduction maintenance:off'
#alias deploy_hstaging='hstaging maintenance:on && git push staging && hstaging run rake db:migrate && hstaging maintenance:off'


############################################################
## Node / NPM
############################################################


noindex_node_modules () {
    find ~/Code -maxdepth 3 -type d -name 'node_modules' -exec touch {}/.metadata_never_index \;
}


############################################################
## Rails
############################################################

alias bi="bundle install"
alias rg="rake -T | grep"

#alias tl="tail -f log/development.log"

# Rails 3 or 4
# function r {
#   if [ -e "script/rails" ]; then
#     script/rails $*
#   else
#     rails $* # Assumes ./bin is in the PATH
#   fi
# }


############################################################
## Emacs
############################################################

alias e="emacs -x"
alias ee="e ~/.emacs"

#alias e='emacs'

#alias install_emacs='brew install emacs --srgb --with-cocoa'
#alias install_emacs_head='brew install emacs --HEAD --srgb --with-cocoa'
#alias link_emacs='ln -snf /usr/local/Cellar/emacs/24.5/bin/emacs /usr/local/bin/emacs && ln -snf /usr/local/Cellar/emacs/24.5/bin/emacsclient /usr/local/bin/emacsclient && brew linkapps emacs'
#alias link_emacs_head='ln -snf /usr/local/Cellar/emacs/HEAD/bin/emacs /usr/local/bin/emacs && ln -snf /usr/local/Cellar/emacs/HEAD/bin/emacsclient /usr/local/bin/emacsclient && brew linkapps emacs'
#alias upgrade_emacs='brew uninstall emacs && install_emacs && link_emacs'
#alias upgrade_emacs_head='brew uninstall emacs && install_emacs_head && link_emacs_head'

############################################################
## Miscellaneous
############################################################

export GREP_COLOR="1;37;41"
alias grep="grep --color=auto"
alias wgeto="wget -q -O -"
alias md5="md5sum"
alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"
alias sha512="openssl dgst -sha512"
alias b64="openssl enc -base64"
alias 256color="export TERM=xterm-256color"
alias dig="dig +noall +answer"

function flushdns {
  if pgrep mDNSResponder > /dev/null
  then # OS X <= 10.9
    dscacheutil -flushcache
  else # OS X >= 10.10
    sudo discoveryutil udnsflushcaches
  fi
}

alias fixtime='sudo ntpdate pool.ntp.org'
#alias whichlinux='uname -a; cat /etc/*release; cat /etc/issue'

#alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

function serve {
  local port=$1
  : ${port:=3000}
  ruby -rwebrick -e"s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd, :MimeTypes => WEBrick::HTTPUtils::load_mime_types('/etc/apache2/mime.types')); trap(%q(INT)) { s.shutdown }; s.start"
}

# function eachd {
#   for dir in *; do
#     cd $dir
#     echo $dir
#     $1
#     cd ..
#   done
# }

function fakefile {
  let mb=$1
  let bytes=mb*1048576
  dd if=/dev/random of=${mb}MB-fakefile bs=${bytes} count=1 &> /dev/null
}

############################################################
alias tailf='tail -f'
alias tailn='tail -n 100'
alias tailnn='tail -n 500'
alias tailnnn='tail -n 2000'

alias cdss='cd ~/Code/marketly/scrubm-social'
alias grv='git remote -v'
alias gf='git fetch'
alias rdbm='rake db:migrate'
alias gcl='git clone'
alias ec='emacsclient'
alias gshl='git stash list'
alias gshs='git stash save'
alias gsh='git stash '
alias gshp='git stash pop'
alias ginit='git init .;git add *  .gitignore; git commit -am initial'
alias rgm='rails g migration'
alias rt='RAILS_ENV=test ruby -Itest'
alias cux="chmod u+x"
alias gcmd="git push && cap master deploy"
alias gpcmd="git push && cap master deploy"

alias cdsc="cd /Users/tyler/Code/marketly/scrubm-clj"
alias sshw='ssh marketly-webserver'
alias sshs='ssh marketly-service'
alias sshsa='ssh marketly-service-a'
alias sshsb='ssh marketly-service-b'

