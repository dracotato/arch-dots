# h[ome]f[ind]
hf() {
  if $(echo "$@" | tr ' ' '\n' | grep -Fqx -- '-h') || [[ -z "$1" ]]; then
    cat << EOF
Fuzzy directory changing for your home directory.

Usage: $0 <target-dir> [search-directory] [v|vi|vim]

[search-directory]: default is your home directory.
[v|vi|vim]: launches nvim after changing to the directory.
EOF
    return
  fi

  if [[ -z $1 ]]; then
    cd "~/$1"
    return
  fi

  pattern="^vi?m?$"
  target=$1
  dir=""

  if [[ ! $@[2] =~ $pattern ]]; then
    dir=$2
  fi

  matches=$(find "$HOME/$dir" -maxdepth 3 -type d -regex ".*$target.*")
  dir=$(echo $matches | awk 'NR==1 {print}')
  cd $dir

  if [[ ${@[-1]} =~ $pattern ]]; then
    nvim .
  fi
}

# convenient wrapper to search just projects
pj() {
  hf projects $@
}

# convenient wrapper to search just dots
dt() {
  hf .dots $@
}

# automatically activate python venvs
venv() {
  if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  fi
}

precmd() { venv; }

# completions
compdef '_files -W ~/' hf
compdef '_files -W ~/projects/' pj
compdef '_files -W ~/.dots/' dt
