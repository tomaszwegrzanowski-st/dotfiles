ulimit -n 65536

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

alias l='ls -l'
alias tt='trash'
alias bi='bundle install'
alias be='bundle exec'
alias br='bundle exec rspec --order defined'
alias gr='pcre2grep'
alias rja='~/overseer/bin/remote-job-adblock'
alias rj='~/overseer/bin/remote-job'

setopt autocd

export GIT_MERGE_AUTOEDIT=no
export EDITOR='code -w'
export RUBY_COVERAGE=no

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

# Simplest branch name in prompt
# from https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
git_branch_test_color() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    if [ -n "$(git status --porcelain)" ]; then
      local gitstatuscolor='%F{red}'
    else
      local gitstatuscolor='%F{green}'
    fi
    echo "${gitstatuscolor} (${ref})"
  else
    echo ""
  fi
}
setopt PROMPT_SUBST
PROMPT='%9c$(git_branch_test_color)%F{none} %# '
