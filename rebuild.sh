#!/bin/bash

# Rebuild Open Atrium and prepare it for installation. Does not actually
# install Open Atrium

# Configure rebuild
# @todo Move to configuration file.
DRUSH=/usr/bin/drush
MYSQL=/usr/bin/mysql
DRUPALPATH=/var/www/atrium/
DBHOST=localhost
DBNAME=atrium
DBUSER=atrium
DBPW=atrium
TMPDIR="/tmp/atrium-test-tmp_"`date +%F_%k-%M-%S`"/"
PROFILECMD="git clone git://github.com/developmentseed/openatrium.git "$TMPDIR"openatrium"
PROFILENAME=openatrium
SETTINGSPATCH=/home/ab/scripts/atrium-testkit/simpletest_settings.patch

# Create temporary build directory.
mkdir $TMPDIR

# Blow away existing installation.
# @todo back up files for later inspection.
$MYSQL -h $DBHOST -u $DBUSER -p$DBPW $DBNAME -e "DROP DATABASE IF EXISTS atrium; CREATE DATABASE atrium;"
rm -rf $WWWDIR$DRUPALPATH

# Download and prepare Drupal.
$DRUSH dl drupal-6.15 --destination=$TMPDIR
mv $TMPDIR"drupal-6.15/" $DRUPALPATH
cp $DRUPALPATH"sites/default/default.settings.php" $DRUPALPATH"sites/default/settings.php"
chmod 666 $DRUPALPATH"sites/default/settings.php"
mkdir $DRUPALPATH"sites/default/files"
chmod 777 $DRUPALPATH"sites/default/files"

# Download and make Open Atrium dev version.
$PROFILECMD
cp -r $TMPDIR$PROFILENAME $DRUPALPATH"profiles/"$PROFILENAME
cd $DRUPALPATH"profiles/"$PROFILENAME
$DRUSH make --yes --working-copy --no-core --contrib-destination=. "openatrium.make.dev"

# Prepare run-test.php and patch with http://drupal.org/node/602332 .
cp $DRUPALPATH"profiles/openatrium/modules/developer/simpletest/run-tests.sh" $DRUPALPATH"scripts/"
cd $DRUPALPATH"/scripts/"
wget "http://drupal.org/files/issues/simpletest-junit-xml-output.patch"
patch -p0 < "simpletest-junit-xml-output.patch"

#Patch settings.php.
cd $DRUPALPATH
patch -p1 < $SETTINGSPATCH

# Clean up, make sure files are writeable to group.
chmod -R g+w $DRUPALPATH
rm -rf $TMPDIR

exit 0
