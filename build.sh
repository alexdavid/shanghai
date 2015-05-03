#!/usr/bin/env bash

export PATH=node_modules/.bin:$PATH

mkdir -p build
browserify -t coffeeify src/client/shanghai.coffee | uglifyjs -m > build/client.js
coffee -p -c src/server.coffee | uglifyjs -m > build/server.js
stylus -o build -c src/client/shanghai.styl
cp src/client/shanghai.html build/shanghai.html
node_modules/electron-prebuilt/dist/Electron.app/Contents/MacOS/Electron .
