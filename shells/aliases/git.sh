# Git functions
function change_branch() {
  branch=$(git branch --all | grep -v "\->" | sed "s/^..//" | fzf --preview "
    git log --oneline --graph --color=always {} | head -100
  " --preview-window=right:70%)

  if [[ -n "${branch}" ]]; then
    git switch "${branch}"
  fi
}


# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gpull="git pull"
alias gpush="git push"
alias gbranch="change_branch"
alias gforce="git push --force-with-lease"  # force push, but only if the remote branch is the same as the local branch
alias gamend="git commit --amend --no-edit"  # amend the last change to the last commit
alias grewrite="git commit --amend"  # modify the last commit message
alias gundo="git reset --soft HEAD~1"  # undo last commit
alias gnuke="git clean -df; git reset --hard"  # removes all untracked files and reset the repo to the last commit
