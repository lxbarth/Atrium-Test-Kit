#!/bin/bash

# Hudson provided variables, uncomment for testing.
WORKSPACE=/tmp
BUILD_ID=`date +%F_%k-%M-%S`
mkdir $WORKSPACE"/atrium-test-tmp_"$BUILD_ID

# Configure rebuild
# @todo Move to configuration file.
DRUSH=/usr/bin/drush
MYSQL=/usr/bin/mysql
DRUPALURL=http://localhost/atrium/
DRUPALPATH=/var/www/atrium/
DBHOST=localhost
DBNAME=atrium
DBUSER=atrium
DBPW=atrium
TMPDIR=$WORKSPACE"/atrium-test-tmp_"$BUILD_ID"/build-tmp/"
PROFILECMD="git clone git://github.com/developmentseed/openatrium.git "$TMPDIR"openatrium"
PROFILENAME=openatrium

# Create temporary directory.
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

# Clean up.
chmod g+w $DRUPALPATH
rm -rf $TMPDIR

exit 0
