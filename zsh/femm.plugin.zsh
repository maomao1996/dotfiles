#--------------------------------------------------#
# alias 相关
#--------------------------------------------------#
# https://github.com/antfu/ni
alias p="pnpm"
alias pnpx="pnpm dlx"
alias d="bun run dev"
alias s="bun run start"
alias b="bun run build"
alias t="bun run test"
alias dp="bun run deploy"
alias lint="nr lint"
alias lintf="nr lint --fix"

# git 相关
alias glogp="git log --pretty='%C(yellow)%h%C(reset) %ad %C(green)%s%C(reset) %C(red)%d%C(reset) %C(bold blue)[%an]%C(reset)'"
alias gcl1="git clone --depth=1"
alias gpp="proxy && git push && unproxy"
alias glp="proxy && git pull && unproxy"
alias dmm="git checkout master && git pull && git merge develop"

# 包别名
alias cat="bat"
alias commit="czg"

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
