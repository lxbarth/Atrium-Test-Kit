#!/bin/bash

# Run Simpletests and place results in Hudson $WORKSPACE directory. Requires
# patch http://drupal.org/node/602332

# Configure test
# @todo Move to configuration file.
PHP=/usr/bin/php
DRUPALPATH=/var/www/atrium/
DRUPALURL=http://localhost/atrium/
TESTS=Atrium
# This directory is created in install.sh
TESTDIR=$WORKSPACE"/"$BUILD_ID"/testresults/"

# Create test directory for test files and run tests.
$PHP $DRUPALPATH"scripts/run-tests.sh" --xml $TESTDIR --url $DRUPALURL $TESTS > /dev/null

exit 0
