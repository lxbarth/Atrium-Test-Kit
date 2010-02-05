#!/bin/bash

# Run install scripts for Atrium Tests and place results in Hudson $WORKSPACE.

set -x

# Configure test
# @todo Move to configuration file.
DRUSH=/usr/bin/drush
PHPUNIT=/usr/bin/phpunit
DRUPALURL=http://localhost/atrium/
DRUPALPATH=/var/www/atrium/
SCRIPT=/home/ab/scripts/atrium-testkit/AtriumInstall.php
TESTDIR=$WORKSPACE"/"$BUILD_NUMBER"-testresults/"

# Create test directory for test files and run tests.
if [ ! -d $TESTDIR ]; then
  mkdir $TESTDIR
fi

$PHPUNIT --log-junit $TESTDIR"install.xml" $SCRIPT
$DRUSH -y r $DRUPALPATH -l $DRUPALURL enable simpletest
