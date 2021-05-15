#!/usr/bin/env bash

set -e

echo 'chdir..'
cd /home/debian/.minecraft
echo "chdir'd"

echo 'copying forge-installer.jar from /opt...'
cp /opt/forge-installer.jar .
echo 'copied'

echo 'Launching forge-installer.jar...'
java -jar forge-installer.jar
echo 'forge-installer.jar exited.'

set +e
