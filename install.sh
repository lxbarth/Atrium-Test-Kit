#!/bin/bash

# Run install scripts for Atrium Tests and place results in Hudson $WORKSPACE.

# Configure test
# @todo Move to configuration file.
PHPUNIT=/user/bin/phpunit
SCRIPT=AtriumInstall.php

# Create test directory for test files and run tests.
TESTDIR=$WORKSPACE"/"$BUILD_ID"/testresults/"
mkdir $TESTDIR
$PHPUNIT --log-junit $TESTDIR"/install.xml" $SCRIPT
