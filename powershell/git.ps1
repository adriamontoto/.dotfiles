# Git Functions


# Git Aliases
${function:gs} = { git status }
${function:ga} = { git add $args }
${function:gc} = { git commit -m $args }
${function:gpull} = { git pull $args }
${function:gpush} = { git push $args }
${function:glog} = { git log --oneline --decorate --color }
${function:gammend} = { git commit --amend --no-edit }
${function:gundo} = { git reset --soft HEAD~1 }
${function:gnuke} = { git clean -df; git reset --hard }
