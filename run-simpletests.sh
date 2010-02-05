#!/bin/bash

# Run Simpletests and place results in Hudson $WORKSPACE directory. Requires
# patch http://drupal.org/node/602332

# Configure test
# @todo Move to configuration file.
PHP=/usr/bin/php
DRUPALPATH=/var/www/atrium/
DRUPALURL=http://localhost/atrium/
TESTS=Atrium

# Create test directory for test files and run tests.
TESTDIR=$WORKSPACE"/"$BUILD_ID"/results-simpletest/"
mkdir $TESTDIR
$PHP $DRUPALPATH"scripts/run-tests.sh" --xml $TESTDIR --url $DRUPALURL $TESTS > /dev/null

exit 0
