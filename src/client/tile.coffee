$ = require 'jquery'


class Tile

  @TYPES = [
    'a1', 'a2', 'a3', 'a4', 'a5', 'a7', 'a8', 'a9'
    'b2', 'b3', 'b4', 'b5', 'b6', 'b7', 'b8', 'b9'
    'c', 'c1', 'c3', 'c4', 'c5', 'c6', 'c7', 'c8', 'c9'
    'd1', 'd4'
    'e', 'f', 'n', 'p', 's', 'w'
  ]

  @PX_WIDTH = 50
  @PX_HEGIHT = 62

  constructor: (@x, @y, @z, @game) ->
    @type = Tile.TYPES[Math.round Math.random() * (Tile.TYPES.length - 1)]
    @el = $ '<div>', class: 'tile'
    @el.css
      width: Tile.PX_WIDTH
      height: Tile.PX_HEGIHT
      left: @x * Tile.PX_WIDTH + 12 * @z
      top: @y * Tile.PX_HEGIHT - 12 * @z
      zIndex: @z * 100 - @x * 2 + @y * 2 + 100
      backgroundImage: "url(../tiles/#{@type}.png)"

    @el.on 'click', => @game.clickTile this


  isAdjacent: (tile) ->
    return no unless Math.abs(tile.y - @y) < 1
    return no unless tile.z is @z
    Math.abs(tile.x - @x) is 1


  isCovering: (tile) ->
    return no if @z <= tile.z
    Math.abs(tile.y - @y) < 1 and Math.abs(tile.x - @x) < 1


  remove: ->
    @el.remove()


  deselect: =>
    @el.removeClass 'selected'


  select: =>
    @el.addClass 'selected'


  render: ->
    @el.appendTo '#game'


module.exports = Tile
