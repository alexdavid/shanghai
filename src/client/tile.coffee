$ = require 'jquery'
{EventEmitter} = require 'events'


class Tile extends EventEmitter

  TYPES = [
    'a1', 'a2', 'a3', 'a4', 'a5', 'a7', 'a8', 'a9'
    'b2', 'b3', 'b4', 'b5', 'b6', 'b7', 'b8', 'b9'
    'c', 'c1', 'c3', 'c4', 'c5', 'c6', 'c7', 'c8', 'c9'
    'd1', 'd4'
    'e', 'f', 'n', 'p', 's', 'w'
  ]

  PX_WIDTH = 50
  PX_HEGIHT = 62


  @getRandomTileType: ->
    TYPES[Math.round Math.random() * (TYPES.length - 1)]


  constructor: (@x, @y, @z, @game) ->
    @el = $ '<div>', class: 'tile'
    @el.css
      width: PX_WIDTH
      height: PX_HEGIHT
      left: @x * PX_WIDTH + 12 * @z
      top: @y * PX_HEGIHT - 12 * @z
      zIndex: @z * 100 - @x * 2 + @y * 2 + 100

    @el.on 'click', => @emit 'click'


  isAdjacent: (tile) ->
    return no unless Math.abs(tile.y - @y) < 1
    return no unless tile.z is @z
    Math.abs(tile.x - @x) is 1


  isCovering: (tile) ->
    return no if @z <= tile.z
    Math.abs(tile.y - @y) < 1 and Math.abs(tile.x - @x) < 1


  isRemovable: ->
    openOnLeft = yes
    openOnRight = yes

    for tile in @game.tiles
      return no if tile.isCovering this
      continue unless tile.isAdjacent this

      openOnLeft = no if tile.x - @x is -1
      openOnRight = no if tile.x - @x is 1

    openOnLeft or openOnRight


  remove: ->
    @el.remove()


  deselect: =>
    @el.removeClass 'selected'


  select: =>
    @el.addClass 'selected'


  setType: (@type) ->
    @el.css backgroundImage: "url(../tiles/#{@type}.png)"


  render: =>
    @el.appendTo '#game'


module.exports = Tile
