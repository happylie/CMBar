#!/usr/bin/env bash

export LANG="ko_KR.UTF-8"
export LC_ALL="ko_KR.UTF-8"
export HOME_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $HOME_PATH

DISPLAY=:0.0
export DISPLAY

date_format="+%Y-%m-%d %H:%M:%S"
echo -e "[+][$(date "$date_format")] Start CMBar App Build Script"

cd ~/Applications
export APP_PATH=`pwd -P`
if [ -d "${APP_PATH}/CMBar.app" ]
then
    echo -e "[+][$(date "$date_format")] Re Make Directory CMBar App"
    rm -r "${APP_PATH}/CMBar.app"
    mkdir -p "${APP_PATH}/CMBar.app/Contents/MacOS"
    mkdir "${APP_PATH}/CMBar.app/Contents/Resources"
else 
    echo -e "[+][$(date "$date_format")] Make Directory CMBar App"
    mkdir -p "${APP_PATH}/CMBar.app/Contents/MacOS"
    mkdir "${APP_PATH}/CMBar.app/Contents/Resources"
fi

cd $HOME_PATH
go mod download
GOMAXPROCS=1 go build -o CMBar 2>err.log
if [ -s "err.log" ];then
    echo -e "[+][$(date "$date_format")] CMBar App Build Error"
    exit 2
fi

cp CMBar ${APP_PATH}/CMBar.app/Contents/MacOS
cp assets/AppIcon.icns ${APP_PATH}/CMBar.app/Contents/Resources
cp assets/info.plist ${APP_PATH}/CMBar.app/Contents
rm CMBar

echo -e "[+][$(date "$date_format")] End CMBar App Build Script"