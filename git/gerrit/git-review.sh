#!/usr/bin/env bash

set -e

# go to repository home
cd "$(git rev-parse --show-toplevel)"

current_branch="$(git rev-parse --abbrev-ref HEAD)"
#message_commit="$(git log --format=%B -n 1)"
message_commit=$(cat .git/COMMIT_EDITMSG)
change_id="$(echo "${message_commit}" | grep -E "^Change-Id:" | cut -f2 -d " ")"

if [[ -z "${change_id}" ]] || [[ $(echo "${change_id}" | wc -l) -ne 1 ]]; then
  >&2 echo "ERROR: Incorrect Change-Id: '${change_id}'"
  exit 1
fi

# print log commit
git log --stat --pretty=fuller -n 1
echo

read -p "Do you want push one review ? [Y/n]: " answer
if [[ "${answer}" != "Y" ]]; then
  exit 0
fi

git push origin HEAD:refs/changes/"${1:-${change_id}}"
