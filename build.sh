#!/usr/bin/env bash

export PATH=node_modules/.bin:$PATH

rm -r dist
rm -r build

mkdir -p build
mkdir dist


cp package.json build
cp -r tiles build
browserify -t coffeeify -t brfs src/client/shanghai.coffee | uglifyjs -m > build/client.js
coffee -p -c src/server.coffee | uglifyjs -m > build/server.js
stylus -o build -c src/client/shanghai.styl
cp src/client/shanghai.html build/shanghai.html

cp -r node_modules/electron-prebuilt/dist/Electron.app dist/Shanghai.app
cp -r Info.plist dist/Shanghai.app/Contents
rm -r dist/Shanghai.app/Contents/Resources/default_app
asar pack build dist/Shanghai.app/Contents/Resources/app.asar
