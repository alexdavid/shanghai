$ = require 'jquery'
defaultLayout = require './layouts/default.coffee'

$('#new-game').on 'click', ->
  $('.game').remove()
  game = defaultLayout.createGameFromLayout()
  game.start()
