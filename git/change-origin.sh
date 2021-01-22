#!/usr/bin/env bash

# Script uses getopts for argument parsing.
# Checks if a remote origin for current pwd exists.
# If it doesn't exist then remote origin is added
# If it exists then remote origin is changed to the one specified by args.

usage()
{

  DIR=$(pwd)
  cat << EOF
  usage: $0 options
  ------------------------------------------------------------
  This script changes the git remote origin for: $DIR.

  OPTIONS:
    -h      Show this message
    -u      Username
    -r      Repository
    -v      Verbose

  ------------------------------------------------------------
EOF
}

verbose()
{
  if [[ $VERBOSE -eq 1 ]]; then
    echo "$1"
  fi

}

while getopts “hu:r:v” OPTION; do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    u)
      USER=$OPTARG
      ;;
    r)
      REPO=$OPTARG
      ;;
    v)
      VERBOSE=1
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

if [[ -z "$USER" ]] || [[ -z "$REPO" ]]; then
  usage
  exit 1
fi

ORIGIN=$(git remote -v)

echo ""
verbose "Changing origin:"
echo "------------------------------------------------------------"
USERNAME="git@github.com:$USER"
verbose "Setting user name to: $USERNAME"
REPONAME="$USERNAME/$REPO.git"
verbose "Setting repo name to: $REPONAME"
echo "------------------------------------------------------------"
verbose "Executing git commands.."

if [[ -z "$ORIGIN" ]]; then
  verbose "No origin found. Creating new.."
  COMMAND="add"
else
  verbose "Origin found. Changing origin.."
  COMMAND="set-url"
fi

git remote $COMMAND origin "$REPONAME"
verbose ""
git remote -v
echo "============================================================"
echo "done.."
echo ""
