#!/bin/sh

if [ -z "$TRAVIS_BRANCH" ]; then exit; fi
if [ "$TRAVIS_BRANCH" != master ]; then exit; fi
if [ "$TRAVIS_PULL_REQUEST" != false ]; then exit; fi

export SSH_KEYFILE="$(readlink -f .deploy-key)"
export GIT_SSH="$(readlink -f ssh.sh)"
git clone -b gh-pages git@github.com:freenode/web-7.0.git .deploy || exit 1
cd .deploy || exit 1
git config user.name travis
git config user.email travis@nowhere
rm -rf *
cp -r ../out/* .
cp -r ../static .
git add -A
git commit -m "travis: $TRAVIS_COMMIT"
git push || exit 1
