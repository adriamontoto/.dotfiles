# Git Functions
function change_branch() {
  branch=$(git branch --all | grep -v '\->' | sed 's/^..//' | fzf --preview '
    git log --oneline --graph --color=always {} | head -100
  ' --preview-window=right:70%)

  if [[ -n "$branch" ]]; then
    git checkout "$branch"
  fi
}


# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gpull='git pull'
alias gpush='git push'
alias gbranch='change_branch'
alias gforce='git push --force-with-lease'  # Force push, but only if the remote branch is the same as the local branch
alias glog='git log --oneline --decorate --color'
alias gamend='git commit --amend --no-edit'  # Amend the last chnage to the last commit
alias grewrite='git commit --amend'  # Modify the last commit message
alias gundo='git reset --soft HEAD~1'  # Undo last commit
alias gnuke='git clean -df; git reset --hard'  # Removes all untracked files and reset the repo to the last commit
