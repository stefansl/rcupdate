#!/bin/sh
# Updatescript für Roundcube
# Autor StefanSL

APPPATH="/var/www/clickpress/apps/"
RCPATH="${APPPATH}roundcube"
USRGRP="clickpress.clickpress"


# GET VERSIONNUMBER
VERSION=`curl -s https://api.github.com/repos/roundcube/roundcubemail/releases/latest | grep 'tag_name' | cut -d\" -f4`

# GET PACKAGE
wget https://github.com/roundcube/roundcubemail/releases/download/${VERSION}/roundcubemail-${VERSION}.tar.gz
tar xvfz roundcubemail-${VERSION}.tar.gz
cd roundcubemail-${VERSION}

# GET DEPS
cp composer.json-dist composer.json
composer install --no-dev

# INSTALL TO ORIGINAL 
./bin/installto.sh $RCPATH

#RIGHTS
chown -R $USRGRP $RCPATH

#CLEAN UP
cd .. && rm -R ${APPPATH}roundcubemail-${VERSION} &&rm -R ${APPPATH}roundcubemail-${VERSION}.tar.gz
