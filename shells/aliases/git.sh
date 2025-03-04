# Git functions
function switch_branch() {
    local current_branch=$(git symbolic-ref --short -q HEAD)
    if [[ -z "${current_branch}" ]]; then
        current_branch=$(git for-each-ref --format='%(refname:short)' refs/heads --contains HEAD | head -n 1)
    fi

    if [[ -z "${current_branch}" ]]; then
        current_branch="HEAD"
    fi

    local branch=$(
        git branch --format="%(refname:short)" |
            sed "s/^${current_branch}$/\x1b[1;32m&\x1b[0m/" |
            grep -v '^(HEAD' |
            fzf \
                --ansi \
                --cycle \
                --border \
                --no-sort \
                --layout="reverse-list" \
                --prompt="Switch Git Branch> " \
                --header="Current branch: ${current_branch}" \
                --preview "git log --oneline --color=always {1} | head -100"
    )

    if [[ -z "${branch}" ]]; then
        return 1
    fi

    git switch "${branch}"
}

function checkout_commit() {
    local current_branch=$(git symbolic-ref --short -q HEAD)
    if [[ -z "${current_branch}" ]]; then
        # If HEAD is detached, try to find a branch containing the current commit
        current_branch=$(git for-each-ref --format='%(refname:short)' refs/heads --contains HEAD | head -n 1)
    fi

    if [[ -z "${current_branch}" ]]; then
        current_branch="HEAD"
    fi

    local current_commit=$(git rev-parse --short HEAD)
    local commit=$(
        git log --oneline "${current_branch}" |
            sed "/^${current_commit}/ s/.*/\x1b[1;32m&\x1b[0m/" |
            fzf \
                --ansi \
                --cycle \
                --border \
                --no-sort \
                --layout="reverse-list" \
                --prompt="Checkout Git Commit> " \
                --preview "git show --color=always {1}" \
                --header="Current commit: ${current_commit}" |
            awk '{print $1}'
    )

    if [[ -z "${commit}" ]]; then
        return 1
    fi

    git checkout "${commit}"
}

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gpull="git pull"
alias gpush="git push"
alias gbranch="switch_branch"
alias gcommit="checkout_commit"
alias gforce="git push --force-with-lease"    # force push, but only if the remote branch is the same as the local branch
alias gamend="git commit --amend --no-edit"   # amend the last change to the last commit
alias grewrite="git commit --amend"           # modify the last commit message
alias gundo="git reset --soft HEAD~1"         # undo last commit
alias gnuke="git clean -df; git reset --hard" # removes all untracked files and reset the repo to the last commit
