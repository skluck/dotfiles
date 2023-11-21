arch=$(uname -m)

# ------------------------------------------------------------------------------
# homebrew
# ------------------------------------------------------------------------------

# Dynamically load which homebrew binaries based on terminal mode
HOMEBREW_BIN="$HOME/homebrew/bin"
if [[ "${arch}" == "x86_64" ]] ; then
    echo "Loading x86 terminal..."
    HOMEBREW_BIN="$HOME/homebrew-x86/bin"
    export LD_LIBRARY_PATH="$HOME/homebrew-x86/lib:$LD_LIBRARY_PATH"
    export DYLD_LIBRARY_PATH="$HOME/homebrew-x86/lib:$DYLD_LIBRARY_PATH"
    export LIBRARY_PATH="$HOME/homebrew-x86/lib:$LIBRARY_PATH"
fi

export PATH="$HOME/bin:$HOMEBREW_BIN:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# ------------------------------------------------------------------------------
# history
# ------------------------------------------------------------------------------

# Auto-set by MacOS, but duplicated here for other platforms
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
unsetopt EXTENDED_HISTORY
unsetopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS

# ------------------------------------------------------------------------------
# misc
# ------------------------------------------------------------------------------

if [[ "${arch}" == "x86_64" ]] ; then
    export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d-x64/plugin-cache"
else
    export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
fi
[ ! -d "$TF_PLUGIN_CACHE_DIR" ] && mkdir -p "$TF_PLUGIN_CACHE_DIR"

# Ensure zshell treats all the right chars at word separators (to support improved opt+arrow jumping)
export WORDCHARS=

# ------------------------------------------------------------------------------
# asdf init
# ------------------------------------------------------------------------------

# Terraform is flaky when using rosetta
export ASDF_HASHICORP_OVERWRITE_ARCH_TERRAFORM=arm64

# asdf initialization
if [[ $(command -v brew) ]] ; then
    PREFIX=$(brew --prefix asdf)
    if [[ -d "${PREFIX}" ]]; then
        source $PREFIX/libexec/asdf.sh
    fi
fi

# ------------------------------------------------------------------------------
# python settings
# ------------------------------------------------------------------------------

# Find venv and activate automatically. Note this cannot be in a sub-include, it must follow asdf shim
[ -f "$PWD/venv/bin/activate" ] && source "$PWD/venv/bin/activate"
[ -f "$PWD/virtualenv/bin/activate" ] && source "$PWD/virtualenv/bin/activate"

# ------------------------------------------------------------------------------
# shell prompt
# ------------------------------------------------------------------------------

# Prevent venv from modifying prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# git clone https://github.com/olivierverdier/zsh-git-prompt ~/zshell/git-prompt.zsh
if [ -d ~"/zshell/git-prompt.zsh" ] ; then
    source ~/zshell/git-prompt.zsh/git-prompt.zsh
    source ~/zshell/git-prompt.zsh/examples/pure.zsh
else
    echo "ERROR: Missing clone of https://github.com/woefe/git-prompt.zsh. Prompt may be broken!"
    echo "Run the following:"
    echo "git clone https://github.com/woefe/git-prompt.zsh ~/zshell/git-prompt.zsh"
    echo
fi

function awsprompt() {
    if [ -n "${AWS_PROFILE}" ] ; then
        echo -n " ☁️  ${AWS_PROFILE}"
    else
        echo -n " NO-AWS"
    fi
}
function venvprompt() {
    if [ -n "${VIRTUAL_ENV}" ] ; then
        echo -n " 🐍 $(basename ${VIRTUAL_ENV})"
    fi
}

ZSH_NEWLINE=$'\n'
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[green]%}"
ZSH_USER='%B%F{black}[%F{red}%n%F{black}@%F{red}%m%F{black}]%f%b'
ZSH_PATH='%B%F{black}[%F{yellow}%~%F{black}]%f%b'
ZSH_EXIT_CODE='%B%(?.%F{green}√.%F{red}𐄂%?)%f%b'
ZSH_AWS_PROFILE='%B%F{214}$(awsprompt)%f%b'
ZSH_VENV_PROFILE='%B%F{green}$(venvprompt)%f%b'
ZSH_GIT_DATA='%F{black}%B[ %b%F{green}$(gitprompt)%F{black}%B]%b%f'

PROMPT="${ZSH_USER}%F{black}-%f${ZSH_PATH} ${ZSH_EXIT_CODE}${ZSH_AWS_PROFILE}${ZSH_VENV_PROFILE} ${ZSH_GIT_DATA}${ZSH_NEWLINE}> "
