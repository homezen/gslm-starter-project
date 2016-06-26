#!/bin/bash

set -ex

# Optional: set git user config for CI
# git config --global user.email "circleci@mydomain.com"
# git config --global user.name "CircleCI"
git config --global push.default simple

CI_MSG_PREFIX=":arrow_up: CircleCI: Releasing"
LAST_COMMIT_MSG="$(git log -1 --pretty=%B)"
SEMVER_BUMP_TYPE="$(echo ${LAST_COMMIT_MSG} | sed -n 's/^.*[rR]elease v+\([a-z]\+\).*$/\1/p')"

if echo ${LAST_COMMIT_MSG} | grep "${CI_MSG_PREFIX}"; then
    echo "Last commit was by CI.  Not releasing."
elif [ -n "${SEMVER_BUMP_TYPE}" ]; then
    npm version ${SEMVER_BUMP_TYPE} -m "${CI_MSG_PREFIX} %s"
else
    npm version patch -m "${CI_MSG_PREFIX} %s"
fi

git push
git push --tags
