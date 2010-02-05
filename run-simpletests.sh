#!/bin/bash

# Run Simpletests and place results in Hudson $WORKSPACE directory. Requires
# patch http://drupal.org/node/602332

# Configure test
# @todo Move to configuration file.
PHP=/usr/bin/php
DRUPALPATH=/var/www/atrium/
DRUPALURL=http://localhost/atrium/
TESTS=Atrium
TESTDIR=$WORKSPACE"/"$BUILD_NUMBER"/testresults/"

# Create test directory for test files and run tests.
if [ ! -d $TESTDIR ]; then
  mkdir $WORKSPACE"/"$BUILD_NUMBER
  mkdir $TESTDIR
fi
$PHP $DRUPALPATH"scripts/run-tests.sh" --xml $TESTDIR --url $DRUPALURL $TESTS > /dev/null

exit 0
