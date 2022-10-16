#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat << EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] -u https://podcasts.google.com/feed/aHR0cDovL2ZlZWRzLmZlZWRidXJuZXIuY29tL1BvZGNhc3RDb2ZmZWVCcmVhaw?sa=X&ved=0CD4Q9sEGahcKEwjw1Zv4i8_6AhUAAAAAHQAAAAAQEw -d /content/podcast/

Download all content from Google podcast via (youtube-dl)

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-u, --url       URL of podcast on google podcast
-d, --dir      DIR to storage podcast
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params 
  flag=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    #-f | --flag) flag=1 ;; # example flag
    -d | --dir)
      dir="${2-}"
      shift
      ;;
    -u | --url) # example named parameter
      url="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  [[ -z "${url-}" ]] && die "Missing required parameter: param"
  #[[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

download_podcast() {
    echo ""
    msg "Dowloading ${url}... to dir ${dir}"
    youtube-dl -x --audio-format mp3 -ciw -o ${dir}'/%(playlist_index)s.%(ext)s' -v --playlist-reverse "${url}"
}

parse_params "$@"
setup_colors
download_podcast

# script logic here

# msg "${RED}Read parameters:${NOFORMAT}"
# msg "- flag: ${flag}"
# msg "- param: ${param}"
# msg "- arguments: ${args[*]-}"