ulimit -n 65536

alias l='ls -l'
alias tt='trash'
alias bi='bundle install'
alias be='bundle exec'
alias gr='pcre2grep'

setopt autocd

export GIT_MERGE_AUTOEDIT=no
export EDITOR='code -w'

export PATH=~/bin:~/src/unix-utilities/bin:$PATH

# don't need both
# eval "$(rbenv init - zsh)"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/taw/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Bugfix until spring gets removed
export REMOTE_JOB_DISABLE_SPRING=true

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi
