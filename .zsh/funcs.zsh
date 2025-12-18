# easy access to the projects directory
pj() {
  if [[ -z $1 ]]; then
    cd ~/projects/
    return
  fi
  matches=$(find ~/projects -maxdepth 3 -type d -regex ".*$1.*")
  dir=$(echo $matches | awk 'NR==1 {print}')
  cd $dir
}

# ease access to dots
dt() {
  if [[ -z $1 ]]; then
    cd ~/.dots/
    return
  fi
  matches=$(find ~/.dots -maxdepth 3 -type d -regex ".*$1.*")
  dir=$(echo $matches | awk 'NR==1 {print}')
  cd $dir
}

# automatically activate python venvs
venv() {
  if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  fi
}

precmd() { venv; }

# completions
compdef '_files -W ~/projects/' pj
compdef '_files -W ~/.dots/' dt
