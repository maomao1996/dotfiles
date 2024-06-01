# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

#--------------------------------------------------#
# 加载 p10k 主题
#--------------------------------------------------#
zinit ice depth=1
zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

#--------------------------------------------------#
# 加载 maomao 的自定义配置插件
#--------------------------------------------------#
# 处理 GitHub 用户名和邮箱地址
export githubName=""              # github 用户名
export githubEmail=""             # github 邮箱地址
export githubRepoUser=""          # GitHub 仓库用户名

zinit snippet "https://github.com/maomao1996/dotfiles/blob/main/zsh/femm.plugin.zsh"

#--------------------------------------------------#
# 加载高亮和自动补全插件
#--------------------------------------------------#
zinit ice lucid wait="0" atload="_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

#--------------------------------------------------#
# 加载 Oh My Zsh 中的插件
#--------------------------------------------------#
zinit ice svn
zinit lucid wait="0" atload="check_command eza && alias ls='eza -F'" for \
    OMZL::clipboard.zsh \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::theme-and-appearance.zsh \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::vscode \
    OMZP::eza

#--------------------------------------------------#
# 内置环境变量修改
#--------------------------------------------------#
export LESS="-R"

# 历史记录设置
HISTSIZE=10000
SAVEHIST=100000
HIST_STAMPS="yyyy-mm-dd"

# 忽略重复
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups

#--------------------------------------------------#
# 加载其他功能
#--------------------------------------------------#
# autojump
[ -s $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# fnm
export PATH="$HOME/Library/Application Support/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
