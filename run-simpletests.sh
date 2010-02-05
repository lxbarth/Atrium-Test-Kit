#!/bin/bash

# Run Simpletests and place results in Hudson $WORKSPACE directory. Requires
# patch http://drupal.org/node/602332

# Configure test
# @todo Move to configuration file.
PHP=/usr/bin/php
DRUPALPATH=/var/www/atrium/
DRUPALURL=http://localhost/atrium/
TESTS=Atrium
TESTDIR=$WORKSPACE"/"$BUILD_NUMBER"-testresults/"

# Create test directory.
if [ ! -d $TESTDIR ]; then
  mkdir $TESTDIR
fi

# Run tests.
$PHP $DRUPALPATH"scripts/run-tests.sh" --xml $TESTDIR --url $DRUPALURL $TESTS

exit 0
