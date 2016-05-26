#!/bin/bash
if [ -f $1 ]
then
  echo 'Please enter a pantheon username'
  exit
fi
if [ -f $2 ]
then
  echo 'Please enter a pantheon password'
  exit
fi
if [ -f $3 ]
then
  echo 'Please enter a pantheon site name'
  exit
fi
echo 'Login to terminus'
terminus auth login $2 --password=$3
echo 'Remove old db files'
rm dblive.sql.gz
rm dblive.sql
echo 'Get backup db via terminus'
terminus site backups get  --site=$3 --env=live --element=db --latest --to=dblive.sql.gz
echo 'Unzip the db file'
gunzip dblive.sql.gz
echo 'Drush drop db'
drush sql-drop -y
echo 'Drush import db'
drush sqlc < dblive.sql -y
echo 'Remove db file'
rm dblive.sql
echo 'Drush clear cache'
drush cc all
echo 'Run drush uli'
drush uli
