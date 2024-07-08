# Git Functions


# Git Aliases
${function:gs} = { git status }
${function:ga} = { git add $args }
${function:gc} = { git commit -m $args }
${function:gpull} = { git pull $args }
${function:gpush} = { git push $args }
${function:gforce} = { git push --force-with-lease $args }  # Force push, but only if the remote branch is the same as the local branch
${function:glog} = { git log --oneline --decorate --color }
${function:gamend} = { git commit --amend --no-edit }  # Amend the last chnage to the last commit
${function:grewrite} = { git commit --amend }  # Modify the last commit message
${function:gundo} = { git reset --soft HEAD~1 }  # Undo last commit
${function:gnuke} = { git clean -df; git reset --hard }  # Removes all untracked files and reset the repo to the last commit
