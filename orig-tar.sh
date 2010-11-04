#!/bin/sh 

set -e

package="`dpkg-parsechangelog | sed -n 's/^Source: //p'`"
version="`dpkg-parsechangelog | sed -n 's/^Version: //p' | sed 's/-.*$//'`"
REPO="http://github.com/zeromq/pyzmq.git"
TAR="${package}_${version}.orig.tar.gz"
DIR="${package}-${version}.orig"

git clone ${REPO} ${DIR}
cd ${DIR} && git checkout $version && cd ..
GZIP=--best tar --exclude=.git --numeric --group 0 --owner 0 -cvzf ${TAR} ${DIR}
rm -rf ${DIR} qr_code
