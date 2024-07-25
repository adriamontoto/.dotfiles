#############################################
############ USER CONFIGURATION #############
#############################################
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time


# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

#############################################
################## ALIASES ##################
#############################################
source ~/.dotfiles/zsh/git.zsh
source ~/.dotfiles/zsh/python.zsh
source ~/.dotfiles/zsh/system.zsh

#############################################
################## PLUGINS ##################
#############################################
# TODO: install syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
# TODO: install autosuggestions: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
plugins=(sudo
         git
	     command-not-found
         zsh-syntax-highlighting
         zsh-autosuggestions)
