#--------------------------------------------------#
# utils 相关
#--------------------------------------------------#
# 检查命令是否存在
function check_command() {
  ((${commands[$1]+1}))
}

# 在命令存在时才执行
function safe_run() {
  check_command "$1" && "$@"
}

#--------------------------------------------------#
# alias 相关
#--------------------------------------------------#
# pnpm
alias p="pnpm"
alias pnpx="pnpm dlx"

# bun run 更快
alias d="bun run dev"
alias s="bun run start"
alias b="bun run build"
alias t="bun run test"
alias dp="bun run deploy"
alias lint="bun run lint"
alias lintf="bun run lint --fix"

# https://github.com/antfu-collective/ni
alias nio="ni --prefer-offline"

# git 相关
alias glogp="git log --pretty='%C(yellow)%h%C(reset) %ad %C(green)%s%C(reset) %C(red)%d%C(reset) %C(bold blue)[%an]%C(reset)'"
alias gcl1="git clone --depth=1"
alias gpp="proxy && git push && unproxy"
alias glp="proxy && git pull && unproxy"
alias dmm="git checkout master && git pull && git merge develop"

# IP
alias ip="ipconfig getifaddr en0"
alias cip="curl cip.cc"

# 第三方工具
alias commit="czg"
check_command bat && alias cat="bat"

# 打开配置文件
alias .zshrc="code $HOME/.zshrc"
alias .p10k="code $HOME/.p10k.zsh"
alias .hosts="code /etc/hosts"

#--------------------------------------------------#
# 目录相关
#
# `~/code/i`      for my projects
# `~/code/f`      for forks
# `~/code/r`      for reproductions
# `~/code/others` for others
#--------------------------------------------------#
function i() {
  cd $HOME/code/i/$1
}

function forks() {
  cd $HOME/code/f/$1
}

function repros() {
  cd $HOME/code/r/$1
}

function others() {
  cd $HOME/code/others/$1
}

# clone 相关
function clone() {
  if [[ -z $2 ]]; then
    git clone "$@" && cd "$(basename "$1" .git)"
  else
    git clone "$@" && cd "$2"
  fi
}

function clonei() {
  i && clone "$@" && code . && cd ~2
}

function clonef() {
  forks && clone "$@" && code . && cd ~2
}

function cloner() {
  repros && clone "$@" && code . && cd ~2
}

function cloneo() {
  others && clone "$@" && code . && cd ~2
}

#--------------------------------------------------#
# zinit 相关
#--------------------------------------------------#
# 更新 zinit 和所有插件
function update() {
  proxy

  if [[ $1 == "femm" ]]; then
    zinit update "https://github.com/maomao1996/dotfiles/blob/main/zsh/femm.plugin.zsh"
  else
    zinit self-update && zinit update --parallel --all
  fi

  unproxy
}

#--------------------------------------------------#
# 代理相关
#--------------------------------------------------#
function proxy() {
  local http="http://127.0.0.1:7890"
  local socks5="socks5://127.0.0.1:7890"

  export http_proxy=$http
  export HTTP_PROXY=$http

  export https_proxy=$http
  export HTTPS_PROXY=$http

  export all_proxy=$socks5
  export ALL_PROXY=$socks5

  echo "\033[32m已开启终端代理\033[0m"
}

function unproxy() {
  unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY all_proxy ALL_PROXY
  echo "\033[32m已关闭终端代理\033[0m"
}

#--------------------------------------------------#
# 其他
#--------------------------------------------------#
# 复制当前项目名和分支名（方便提测）
function c() {
  if [[ -d .git ]]; then
    local data="项目名: $(basename $PWD)\n分支名: $(git_current_branch)"

    if echo -n $data | pbcopy; then
      echo -e "$data\n\033[32m复制成功\033[0m"
    else
      echo -e "$data\n\033[33m复制失败，请检查 pbcopy 是否可用\033[0m"
    fi

  else
    echo "\033[33m当前目录不存在 .git 配置\033[0m"
  fi
}

# 修改 GitHub 用户名和邮箱地址（防止造成用公司信息提交到 github 的尴尬）
if [[ -d .git && $githubRepoUser ]]; then
  # 获取当前仓库和用户信息
  local remoteUrl=$(git remote get-url origin)

  # 判断是否为指定用户的 GitHub 仓库
  if [[ $githubRepoUser && $remoteUrl =~ "/github.com/$githubRepoUser/" ]]; then
    # 提示当前为 GitHub 项目（不需要可注释）
    echo -e "\033[34m当前正在处理 GitHub 用户 ($githubRepoUser) 的项目\033[0m"

    local currentName=$(git config user.name)
    local currentEmail=$(git config user.email)

    if [[ $githubUser && $githubUser != $currentName ]]; then
      git config user.name "$githubUser"
      echo -e "已将当前仓库的用户名从\033[33m $currentName \033[0m修改为\033[32m $githubUser \033[0m"
    fi

    if [[ $githubEmail && $githubEmail != $currentEmail ]]; then
      git config user.email "$githubEmail"
      echo -e "已将当前仓库的邮箱从\033[33m $currentEmail \033[0m修改为\033[32m $githubEmail \033[0m"
    fi
  fi
fi
