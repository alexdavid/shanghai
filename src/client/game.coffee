$ = require 'jquery'
Tile = require './tile.coffee'


class Game

  constructor: ->
    @el = $ '<div>', class: 'game'
    @el.appendTo 'body'
    @tiles = []
    @selected = null


  addTile: (tile) ->
    @tiles.push tile
    tile.on 'click', => @onTileClick tile


  onTileClick: (tile) ->

    if @selected is tile
      @selected.deselect()
      @selected = null
      return

    unless tile.isRemovable()
      tile.select()
      setTimeout tile.deselect, 150
      return

    if @selected
      if @selected.type is tile.type
        tile.remove()
        @selected.remove()
        @tiles = @tiles.filter (t) => t isnt tile and t isnt @selected
        @selected = null
      else
        @selected.deselect()
        @selected = tile
        @selected.select()
    else
      @selected = tile
      @selected.select()


  getPossibleRandomTileOrder: ->
    results = []
    toBeAdded = @tiles[..].sort -> Math.random() - .5

    canAdd = (tile) =>
      currentlyBelowCount = results.filter((t) -> tile.isCovering t).length
      needsBelowCount = @tiles.filter((t) -> tile.isCovering t).length
      currentlyBelowCount is needsBelowCount

    while tile = toBeAdded.shift()
      until canAdd(tile)
        toBeAdded.push tile
        tile = toBeAdded.shift()
      results.push tile
    results


  start: ->
    waitingOnAdd = null
    for tile, i in @getPossibleRandomTileOrder()

      if waitingOnAdd?
        type = waitingOnAdd
        waitingOnAdd = null
      else
        type = waitingOnAdd = Tile.getRandomTileType()

      tile.setType type
      setTimeout tile.render, i * 15


module.exports = Game
