#!/bin/bash

# small script to turn penpot tokens into css variables

usage="usage: $0 tokens.json theme [prefix]"

if [[ -f $1 ]]; then
  if [[ ! -n $2 ]]; then
    echo $usage
    exit 1
  fi

  keys=()
  mapfile -t keys < <( cat $1 | jq -r ".[\"$2\"] | keys_unsorted[]" )

  NL=$'\n'
  out=""
  for i in ${!keys[@]}; do
    key=${keys[$i]}
    out+=$"--${3:+$3-}$key: $(cat $1 | jq -r ".[\"$2\"].[\"$key\"].[\"\$value\"]");${NL}"
  done
  # remove trailing newline
  echo -n "$out" | wl-copy
else
  if [[ -n $1 ]]; then
    echo "error: $1 not found"
    exit 1
  else # nothing was passed
    echo $usage
  fi
  exit 1
fi
