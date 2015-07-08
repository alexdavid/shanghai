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

    return tile.flicker() unless tile.isRemovable()

    if @selected?.isMatch tile
      @removeTile tile
      @removeTile @selected
      @selected = null
    else
      @selectTile tile


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


  removeTile: (tile) ->
    @tiles = @tiles.filter (t) -> t isnt tile
    tile.remove()


  selectTile: (tile) ->
    @selected?.deselect()
    @selected = tile
    @selected.select()


  start: ->
    seasonAddedIndex = Math.floor Math.random() * @tiles.length
    waitingOnAdd = []
    for tile, i in @getPossibleRandomTileOrder()

      if i is seasonAddedIndex
        waitingOnAdd.push 'winter', 'summer', 'spring', 'autumn'

      if waitingOnAdd.length is 0
        pair = Tile.getRandomTileType()
        waitingOnAdd.push pair, pair

      type = waitingOnAdd.pop()
      tile.setType type
      setTimeout tile.render, i * 10


module.exports = Game
