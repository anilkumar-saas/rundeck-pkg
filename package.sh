#!/bin/bash

set -xe

### The dir for the package script
MY_DIR=$( dirname $0 )
cd $MY_DIR

### Name of the package, project, etc
NAME=rundeck

### This is a symlink to the dir with the version of rundeck we want to build
### This is something like rundeck-2.5.2-1
TARGET=$( basename $( readlink $NAME ) )

### Where the sources live
SOURCE_DIR="${MY_DIR}/${TARGET}"

###
### Plugin/config settings
###
LIBEXT_DIR="${SOURCE_DIR}/var/lib/rundeck/libext"

### The default is a krux-ism, but set that if it's not otherwise specified
JAVA_HOME=${JAVA_HOME-"/usr/local/oracle-java-8/"}
export JAVA_HOME

###
### Package settings
###

### Packaging info
PACKAGE_NAME=$NAME
### Because 1.5.2 > 1.5.2~krux... we prefix the version with 1: to win on sorting.
PACKAGE_VERSION=1:$( echo $TARGET | perl -ne '/([\d.]+)/; print $1')~krux$( date -u +%Y%m%d%H%M )

### Where this package will be installed
### Because this is a re-package of the official debian package, the prefix is /, ie the
### root directory.
DEST_DIR="/"

###
### Plugins to be installed
###

CURL=$( which curl )

PLUGINS=`cat plugins.list | grep -v ^#`
### Install plugins into libext dir
cd $LIBEXT_DIR
for p in $PLUGINS; do
  ${CURL} -L -O $p
done

cd -

###
### Build package
###

### run fpm
FPM=$( which fpm )
$FPM -s dir -t deb -a all -n $PACKAGE_NAME -v $PACKAGE_VERSION --prefix $DEST_DIR -C $SOURCE_DIR $@ .
