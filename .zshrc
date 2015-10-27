# turn off Ctrl+S (XOFF)
stty ixany
stty ixoff -ixon

export PATH=$PATH:$GOPATH/bin:~/bin/
export EDITOR=vim
export BROWSER=chromium
export PS1='[%n@%m %c]$ '
export GOPATH=$HOME/go

alias ccb='xclip -selection c'
alias pcb='xclip -selection clipboard -o'

alias c='clear'
alias vi='vim'
alias ls='ls -G'
alias ll='ls -laG'

# one-liner for every commit
alias gitlog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# lists each branch with age, name, and last committer
alias glist='for ref in $(git for-each-ref --sort=-committerdate --format="%(refname)" refs/heads/ refs/remotes ); do git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an>%Creset%n" | cat ; done | awk '"'! a["'$0'"]++'"

# list files for a specific commit
alias gchange='git diff-tree --no-commit-id --name-only -r'

# `git branch` with branch desc (`git branch --edit-description <branch>`)
alias gb='for branch in $(git for-each-ref --format="%(refname)" refs/heads/ | sed "s|refs/heads/||"); do desc=$(git config branch.$branch.description); if [[ $branch == $(git rev-parse --abbrev-ref HEAD) ]]; then branch="* \033[0;32m$branch\033[0m"; else branch="  $branch" fi; echo -e "$branch \033[0;36m$desc\033[0m" ; done'

# automatically deletes files from the repo that have already been deleted
alias grm='git ls-files --deleted -z | xargs -0 git rm'

# WARNING: removes a given file from _EVERY_ commit in a repo.
# This is especially useful for sensitive data that gets added
# to the repository by accident. Contact GitHub support if you
# need to also remove cached data.
function gitrmfromeverywhere() {
  if [ $# -ne 1 ]; then
    echo 'usage: gitrmfromeverywhere path'
  else
    git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch $1' --prune-empty --tag-name-filter cat -- --all
    git push origin --force --all
    git push origin --force --tags
  fi
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
