#!/bin/sh 

set -e

package="`dpkg-parsechangelog | sed -n 's/^Source: //p'`"
version="`dpkg-parsechangelog | sed -n 's/^Version: //p' | sed 's/-.*$//'`"
REPO="http://github.com/zeromq/pyzmq.git"
commit="`echo $version | sed 's/^.*+git\(.*\)/\1/'`"
TAR="${package}_${version}.orig.tar.gz"
DIR="${package}-${version}.orig"

git clone ${REPO} ${DIR}
cd ${DIR} && git checkout $commit && cd ..
GZIP=--best tar --exclude=.git --numeric --group 0 --owner 0 -cvzf ${TAR} ${DIR}
rm -rf ${DIR}
