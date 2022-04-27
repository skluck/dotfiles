export PATH="$HOME/bin:$HOME/homebrew/bin:$PATH"

export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# git clone https://github.com/olivierverdier/zsh-git-prompt ~/zshell/git-prompt.zsh
source ~/zshell/git-prompt.zsh/git-prompt.zsh
source ~/zshell/git-prompt.zsh/examples/pure.zsh
ZSH_NEWLINE=$'\n'
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[green]%}"
ZSH_USER_AND_PATH='%B%F{black}[%F{red}%n%F{black}@%F{red}%m%F{black}]-[%F{yellow}%~%F{black}]%f%b'
ZSH_EXIT_CODE='%B%(?.%F{green}√.%F{red}𐄂%?)%f%b'
PROMPT="${ZSH_USER_AND_PATH} ${ZSH_EXIT_CODE}"' %F{green}$(gitprompt)%f'"${ZSH_NEWLINE}> "
