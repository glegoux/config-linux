#!/usr/bin/env bash

set -e

current_branch="$(git rev-parse --abbrev-ref HEAD)"
message_commit="$(git log --format=%B -n 1)"
change_id="$(echo "${message_commit}" | grep -E "^Change-Id:" | cut -f2 -d " ")"

if [[ $(echo "${change_id}" | wc -l) -ne 1 ]]; then
  >&2 echo -e "ERROR: Incorrect Change-Id: \n'${change_id}'"
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
