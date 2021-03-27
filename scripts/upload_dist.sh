#!/bin/bash

if [ "$GITHUB_ACTIONS" != "true" ]; then
    echo "This script is only meant to be run in GitHub Actions."
    exit 1
fi

cp -f dist/*.tar.gz upstream/dist/
cp -f dist/*.zip upstream/dist/
cd upstream/dist
LATEST_VERSION="${GITHUB_REF#"refs/tags/"}"
git config --local user.name 'Github Actions'
git config --local user.email 'github-actions@users.noreply.github.com'
git add --all
git commit -m "update to $LATEST_VERSION"
git tag -d "${GITHUB_REF#"refs/tags/"}"
git tag "${GITHUB_REF#"refs/tags/"}"
git push
git push --tags