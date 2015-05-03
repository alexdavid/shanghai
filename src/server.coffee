app = require 'app'
BrowserWindow = require 'browser-window'

mainWindow = null

app.on 'ready', ->
  mainWindow = new BrowserWindow width: 800, height: 570
  mainWindow.loadUrl "file://#{__dirname}/shanghai.html"
