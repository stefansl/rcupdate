#!/bin/sh
# Updatescript für Roundcube
# Autor StefanSL

APPPATH="/var/www/clickpress/apps/"
RCPATH="/var/www/clickpress/apps/roundcube"
USRGRP="clickpress.clickpress"

#GET VERSIONNUMBER
VERSION=`curl -s https://api.github.com/repos/roundcube/roundcubemail/releases/latest | grep 'tag_name' | cut -d\" -f4`

cd ${APPPATH}
wget https://github.com/roundcube/roundcubemail/releases/download/${VERSION}/roundcubemail-${VERSION}.tar.gz
tar xvfz roundcubemail-${VERSION}.tar.gz
cd roundcubemail-${VERSION}
cp composer.json-dist composer.json
composer install --no-dev
./bin/installto.sh $RCPATH
chown -R $USRGRP $RCPATH
cd ..
rm -R ${APPPATH}roundcubemail-${VERSION}
rm -R ${APPPATH}roundcubemail-${VERSION}.tar.gz
