# Git functions


# Git aliases
${function:gs} = { git status }
${function:ga} = { git add $args }
${function:gc} = { git commit -m $args }
${function:gpull} = { git pull $args }
${function:gpush} = { git push $args }
${function:gforce} = { git push --force-with-lease $args }  # force push, but only if the remote branch is the same as the local branch
${function:gamend} = { git commit --amend --no-edit }  # amend the last change to the last commit
${function:grewrite} = { git commit --amend }  # modify the last commit message
${function:gundo} = { git reset --soft HEAD~1 }  # undo last commit
${function:gnuke} = { git clean -df; git reset --hard }  # removes all untracked files and reset the repo to the last commit
