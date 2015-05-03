Game = require './game.coffee'
Tile = require './tile.coffee'


class Layout

  constructor: (@layoutData) ->


  createGameFromLayout: ->
    game = new Game
    for layerTiles, z in @layoutData
      for tile in layerTiles
        [x, y] = tile
        game.addTile new Tile x, y, z, game
    game


module.exports = Layout
