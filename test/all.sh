#!/bin/sh

set -e

export TMPDIR_ROOT=$(mktemp -d /tmp/git-tests.XXXXXX)

# Create dedicated homedir for the tests to avoid polluting the resulting image.
TEST_HOME="${TMPDIR_ROOT}/home"
mkdir -p "${TEST_HOME}"
cp -a ~/.gitconfig "${TEST_HOME}/"
export HOME="${TEST_HOME}"

$(dirname $0)/image.sh
$(dirname $0)/check.sh
$(dirname $0)/get.sh
$(dirname $0)/put.sh

echo -e '\e[32mall tests passed!\e[0m'

rm -rf $TMPDIR_ROOT
