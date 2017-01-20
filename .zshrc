fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit

# turn off Ctrl+S (XOFF)
stty ixany
stty ixoff -ixon

export LANG=en_US.UTF-8
export EDITOR=vim
export BROWSER=chromium
export PS1='$ '
export GPG_TTY=$(tty)
export MAIL=$HOME/Maildir

alias ccb='xclip -selection c'
alias pcb='xclip -selection clipboard -o'

alias vi='vim'
alias ls='ls -G'
alias ll='ls -laG'

alias lsd="ls -ld *" # show directories
alias dirdus='du -sckx * | sort -nr' #directories sorted by size
alias dus='du -kx | sort -nr | less' #files sorted by size
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# one-liner for every commit
alias gitlog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) <%aN|%G?>%Creset' --abbrev-commit"

# lists each branch with age, name, and last committer
alias glist='for ref in $(git for-each-ref --sort=-committerdate --format="%(refname)" refs/heads/ refs/remotes ); do git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an>%Creset%n" | cat ; done | awk '"'! a["'$0'"]++'"

# list files for a specific commit
alias gchange='git diff-tree --no-commit-id --name-only -r'

# `git branch` with branch desc (`git branch --edit-description <branch>`)
alias gb='for branch in $(git for-each-ref --format="%(refname)" refs/heads/ | sed "s|refs/heads/||"); do desc=$(git config branch.$branch.description); if [[ $branch == $(git rev-parse --abbrev-ref HEAD) ]]; then branch="* \033[0;32m$branch\033[0m"; else branch="  $branch" fi; echo -e "$branch \033[0;36m$desc\033[0m" ; done'

# automatically deletes files from the repo that have already been deleted
alias grm='git ls-files --deleted -z | xargs -0 git rm'

if [[ "$(uname)" == "Darwin" ]]; then
    export GOPATH="$HOME/work"
    export PATH="/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/Library/TeX/texbin:/Users/zg/bin:/Users/zg/bin/bc:$GOPATH/bin"
    export COVERALLS_TOKEN="lNrhQzvoDHDcq48cPBuOqQRNkUflpZykK"
    alias git='hub'
    alias bu='brew update --verbose; brew upgrade --verbose; brew cleanup --prune=0 --verbose; brew doctor --verbose'
    # alias to show all Mac App store apps
    alias apps='mdfind "kMDItemAppStoreHasReceipt=1"'
    # rebuild Launch Services to remove duplicate entries on Open With menu
    alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
    alias defhist='history 1 | grep "defaults"'

    rsexp() {
      local lvl=-1;
      if [ $# -eq 1 ]; then
        lvl=$1
      else
        lvl=$(cat -)
      fi
      if (( $(echo "$lvl == -1" | bc -l) )); then
        echo 'usage: rsexp lvl'
      elif (( $(echo "$lvl == 1" | bc -l) )); then
        echo 0
      else
        echo "l=$lvl;sum=0;for(n=1;n<=l-1;n++){sum+=floor(n+300*pow(2,n/7))};floor(1/4*sum)" | bc -l ~/repos/bc/code/funcs.bc
      fi
    }

    rslvl() {
      # it's better to make these static vs looping through and check between two bounds
      local exps=(0 83 174 276 388 512 650 801 969 1154 1358 1584 1833 2107 2411 2746 3115 3523 3973 4470 5018 5624 6291 7028 7842 8740 9730 10824 12031 13363 14833 16456 18247 20224 22406 24815 27473 30408 33648 37224 41171 45529 50339 55649 61512 67983 75127 83014 91721 101333 111945 123660 136594 150872 166636 184040 203254 224466 247886 273742 302288 333804 368599 407015 449428 496254 547953 605032 668051 737627 814445 899257 992895 1096278 1210421 1336443 1475581 1629200 1798808 1986068 2192818 2421087 2673114 2951373 3258594 3597792 3972294 4385776 4842295 5346332 5902831 6517253 7195629 7944614 8771558 9684577 10692629 11805606 13034431 14391160 15889109 17542976 19368992 21385073 23611006 26068632 28782069 31777943 35085654 38737661 42769801 47221641 52136869 57563718 63555443 70170840 77474828 85539082 94442737 104273167);
      local exp=-1;
      if [ $# -eq 1 ]; then
        exp=$1
      else
        exp=$(cat -)
      fi
      if [ "$exp" -lt 0 ]; then
        echo 'usage: rslvl exp'
      else
        for lvl in {1..120}; do
          if [ "$exp" -ge "$exps[$lvl]" -a "$exp" -lt "$exps[$lvl+1]" ]; then
            echo $lvl
            break
          fi
        done
      fi
    }
fi

# WARNING: removes a given file from _EVERY_ commit in a repo.
# This is especially useful for sensitive data that gets added
# to the repository by accident. Contact GitHub support if you
# need to also remove cached data.
gitrmfromeverywhere() {
  if [ $# -ne 1 ]; then
    echo 'usage: gitrmfromeverywhere path'
  else
    git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch $1' --prune-empty --tag-name-filter cat -- --all
    git push origin --force --all
    git push origin --force --tags
  fi
}

printescaped() {
  setopt localoptions extendedglob
  echo ${1//(#b)(?)/\&\#$(( #match ))\;}
}

git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'

# make sure keys are configured correctly

bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# write to history immediately after each
# command gets run
setopt INC_APPEND_HISTORY

# This is useful when I want to find a command
# I've previously used (i.e. tar/ps params),
# or Ctrl+R
HISTSIZE=100000
if (( ! EUID )); then
    HISTFILE=~/.history_root
else
    HISTFILE=~/.history
fi
SAVEHIST=100000
