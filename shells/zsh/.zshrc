# zmodload zsh/zprof

export ZSH="${HOME}/.oh-my-zsh"
export LANG="en_US.UTF-8"
export ARCHFLAGS="-arch x86_64"

ZSH_THEME="robbyrussell-hour"
HIST_STAMPS="dd/mm/yyyy"

zstyle ':omz:update' mode reminder # Just remind me to update when it's time

plugins=(
    sudo
    git
    command-not-found
    zsh-syntax-highlighting
    zsh-autosuggestions)

source "${ZSH}/oh-my-zsh.sh"

for file in $(find "${HOME}/.dotfiles/shells/aliases" -type f -name "*.sh"); do
    source "${file}"
done

# zprof
