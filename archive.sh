#!/usr/bin/env bash

set -eou pipefail

rootDir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
archiveDir="$rootDir/archives"

print-help() {
  cat <<EOF
Usage:
  $(basename "$0") [OPTIONS] [ARCHIVE_NAME]

Description:
  Create or extract a tar.xz archive for job application assets.
  Archive file path: $archiveDir/<ARCHIVE_NAME>.tar.xz

Operations (choose one):
  -c, --create    Create an archive
  -x, --extract   Extract an archive

Extract selection:
  -a, --all       Extract all sections (default)
  -r, --resume    Extract resume components
  -l, --letter    Extract cover letter components
  -i, --info      Extract common info components
  -j, --job       Extract job description, must be ./job-desc
                  If no extract selection is provided with --extract, defaults to --all.

Other:
  -h, --help      Show this help

Notes:
  - ARCHIVE_NAME is optional; if omitted, you will be prompted.
  - Passing both --create and --extract is not supported.

Examples:
  $(basename "$0") -c acme
  $(basename "$0") -x acme # extract all components
  $(basename "$0") -xa acme # extract all components
  $(basename "$0") -xrl acme # extract only the resume and letter components
EOF
exit 0
}

proceed() {
  ans=y
  if [ -f "$f" ]; then
    echo "$f already exists. Overwrite? [y]/n"
    read -r ans
  fi

  ans=${ans,,}
  if [[ -z "$ans" || "$ans" == "y" || "$ans" == "yes" ]]; then
    return 0
  else
    return 1
  fi
}

get-name() {
  echo "Specify archive name:"
  read name
}

create() {
  if proceed; then
    tar -cJf "$f" \
      -C "$rootDir" \
      resume/components \
      cover/components \
      common/info \
      job-desc*
  fi
}

extract-resume() {
  extractDir="$rootDir/resume/components"
  tar -xf "$f" --strip-components=2 -C "$extractDir" "resume/components/*"
}

extract-letter() {
  extractDir="$rootDir/cover/components"
  tar -xf "$f" --strip-components=2 -C "$extractDir" "cover/components/*"
}

extract-info() {
  extractDir="$rootDir/common/info"
  tar -xf "$f" --strip-components=2 -C "$extractDir" "common/info/*"
}

extract-job() {
  extractDir="$rootDir"
  tar -xf "$f" -C "$extractDir" "job-desc*"
}

extract() {
  if [ ! -f "$f" ]; then
    echo "$f doesn't exist"
    exit 1
  fi

  if (( ! all && ! resume && ! letter && ! info && ! job)); then
    all=1
  fi

  if (( all )); then
    extract-resume
    extract-letter
    extract-info
    extract-job
    exit 0
  fi

  if (( resume )); then
    extract-resume
  fi

  if (( letter )); then
    extract-letter
  fi

  if (( info )); then
    extract-info
  fi
  
  if (( job )); then
    extract-job
  fi
  exit 0
}

short="cxarlijh"
long="create,extract,all,resume,letter,info,job,help"
opts=$(getopt \
    --options "$short" \
    --long "$long" \
    --name "$(basename "$0")" \
    -- "$@") || {
  echo "Failed parsing options." >&2
  exit 1
}

eval set -- "$opts"

# printf "%s \n" ${opts[*]}

create=0
extract=0
all=0
resume=0
letter=0
info=0
job=0

while (( $# )); do
  case "$1" in
    -h | --help ) print-help; ;;
    -c | --create ) create=1; shift 1 ;;
    -x | --extract ) extract=1; shift 1 ;;
    -a | --all ) all=1; shift 1 ;;
    -r | --resume ) resume=1; shift 1 ;;
    -l | --letter ) letter=1; shift 1 ;;
    -i | --info ) info=1; shift 1 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if (( create && extract )); then
  echo "error: can't create and extract in the same command"
  exit 0
fi

if (( $# == 0 )); then
  get-name
elif (( $# > 1 )); then
  echo "error: too many arguments"
  print-help
  exit 0
else
  name=$1
fi
f="$archiveDir/${name##*.}.tar.xz"

if (( create )); then
  create
fi

if (( extract )); then
  extract
fi
