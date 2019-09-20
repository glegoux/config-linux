#!/usr/bin/env bash

# configuration

GERRIT_URL="" # TO COMPLETE (without '/' at the end) for example: https://gerrit.googlesource.com

if [[ "${GERRIT_URL}" == "" || "${GERRIT_URL}" =~ /$ ]]; then
  >&2 echo "ERROR: please define correctly GERRIT_URL"
  exit 1
fi

# helper function

get_info_gerrit() {
  local change_id="$1"
  local result=$(curl -s "${GERRIT_URL}/changes/${change_id}/?o=CURRENT_REVISION" | sed 1d)
  if [[ $? -eq 0 ]]; then
    echo "${result}"
  fi
}

get_change_number() {
    local result="$1"
    echo "${result}" | jq ._number
}

get_commit_id() {
    local result="$1"
    echo "${result}" | jq .current_revision | sed 's/"//g'
}

get_n_patch_sets() {
    local result="$1"
    local commit_id="$2"
    echo "${result}" | jq .revisions."${commit_id}"._number
}

# script

if [[ "${FUNCNAME[0]}" == "main" ]]; then

  # go to repository home
  cd "$(git rev-parse --show-toplevel)"

  current_branch="$(git rev-parse --abbrev-ref HEAD)"
  message_commit="$(git log --format=%B -n 1)"
  change_id="$(echo "${message_commit}" | grep -E "^Change-Id:" | cut -f2 -d " ")"

  if [[ -z "${change_id}" ]] || [[ $(echo "${change_id}" | wc -l) -ne 1 ]]; then
    >&2 echo "ERROR: Incorrect Change-Id: '${change_id}'"
    exit 1
  fi

  # print commit log
  git log --stat --pretty=fuller -n 1
  echo

  result="$(get_info_gerrit "${change_id}")"
  is_new_review="false"
  if [[ "${result}" == "" ]]; then
    is_new_review="true"
  fi

  if [[ "${is_new_review}" == "true" ]]; then

    echo "*** Create a new review"
    echo
    echo "commit id    : ${commit_id}"
    echo "change number: ${change_number}"
    echo "change id    : ${change_id}"
    echo "patch sets   : 1"
    echo

  else

    change_number="$(get_change_number "${result}")"
    commit_id="$(get_commit_id "${result}")"
    n_patch_sets="$(get_n_patch_sets "${result}" "${commit_id}")"

    echo "*** Update a review"
    echo
    echo "See your current review: ${GERRIT_URL}/${change_number}/"
    echo "commit id    : ${commit_id}"
    echo "change number: ${change_number}"
    echo "change id    : ${change_id}"
    echo "patch sets   : ${n_patch_sets}"
    echo

  fi

  read -p "Do you want push one review on ${current_branch} branch ? [Y/n]: " \
    answer
  if ! [[ "${answer}" =~ ^(|y|Y)$ ]]; then
    exit 0
  fi

  # Possible reference types:
  # changes, for=publish, draft (deprecated)
  #
  # Push with bypassing Code Review:
  # git push origin HEAD:master
  # If pushing to Gerrit fails consult the Gerrit documentation that
  # explains the error messages.

  if [[ "${is_new_review}" == "true" ]]; then
    ref_type="publish"
  else
    ref_type="changes"
  fi

  if [[ "${ref_type}" == "publish" ]]; then
    git push origin HEAD:refs/"${ref_type}"/"${1:-${current_branch}}"
  elif [[ "${ref_type}" == "changes" ]]; then
    git push origin HEAD:refs/"${ref_type}"/"${1:-${change_number}}"
  else
    >&2 echo "ERROR: Unknown reference type: '${ref_type}'"
    exit 1
  fi
  if [[ $? -ne 0 ]]; then
    exit 1
  fi


  result="$(get_info_gerrit "${change_id}")"
  if [[ "${result}" == "" ]]; then
    >&2 echo "ERROR: Impossible to retrieve pushed review!"
    exit 1
  fi
  change_number="$(get_change_number "${result}")"
  echo
  echo "See your pushed review: ${GERRIT_URL}/${change_number}/"

fi

