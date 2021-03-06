alias control_log='tail -f ~/src/macmateusers/filesystem/users/james/logs/control_error_log'
alias public_log='tail -f ~/src/macmateusers/filesystem/users/james/logs/public_error_log'
alias gallery_log='tail -f ~/src/macmateusers/filesystem/users/james/logs/gallery_error_log'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_branch ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
    return 0
  fi
  echo -e "(${gitver}) "
}

branch_color ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
    if git diff --quiet 2>/dev/null >&2
    then
      color="${c_green}"
    else
      color=${c_red}
    fi
  else
    return 0
  fi
  echo -ne $color
}

PS1='\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]\u@\[${c_red}\]\w\[${c_sgr0}\]: '

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f /opt/boxen/env.sh ]; then
  . /opt/boxen/env.sh
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#export NVM_DIR="/Users/james/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh


#Max number of open files
ulimit -S -n 2048
