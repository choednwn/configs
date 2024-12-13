eval "$(/opt/homebrew/bin/brew shellenv)"

# language
export LANG="en_US.UTF-8"

# zoxide
alias cd=z


# move .zcompdump files to a better hidden directory
autoload -Uz compinit
compinit -d ~/.config/zsh/zcompdump
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST


# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# nvim
alias vim=nvim


# llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CFLAGS="-I/opt/homebrew/opt/llvm/include"


# .net core sdk tools
export PATH="$PATH:/Users/choednwn/.dotnet/tools"
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


# zoxide
eval "$(zoxide init zsh)"

# git
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ %F{3}(\1)%f/p'
}

# --------
# zsh
setopt PROMPT_SUBST
PROMPT='%F{6}%n%f:%F{2}%c%f$(parse_git_branch) %(!.#.$) '
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

# zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggest
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"

# style
zstyle ':completion:*' list-colors
# --------
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
