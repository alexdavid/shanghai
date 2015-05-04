$ = require 'jquery'
fs = require 'fs'
{EventEmitter} = require 'events'


class Tile extends EventEmitter

  SEASONS = ['winter', 'summer']
  TYPES = fs.readdirSync 'tiles'
            .filter (file) -> file[0] isnt '.'
            .map (type) -> type.replace '.png', ''
  PX_WIDTH = 50
  PX_HEGIHT = 62


  @getRandomTileType: ->
    loop
      type = TYPES[Math.round Math.random() * (TYPES.length - 1)]
      break unless type in SEASONS
    type


  constructor: (@x, @y, @z, @game) ->
    @el = $ '<div>', class: 'tile'
    @el.css
      width: PX_WIDTH
      height: PX_HEGIHT
      left: @x * PX_WIDTH + 12 * @z
      top: @y * PX_HEGIHT - 12 * @z
      zIndex: @z * 100 - @x * 2 + @y * 2 + 100

    @el.on 'click', => @emit 'click'


  deselect: =>
    @el.removeClass 'selected'


  flicker: ->
    @select()
    setTimeout @deselect, 150


  isAdjacent: (tile) ->
    return no unless Math.abs(tile.y - @y) < 1
    return no unless tile.z is @z
    Math.abs(tile.x - @x) is 1


  isCovering: (tile) ->
    return no if @z <= tile.z
    Math.abs(tile.y - @y) < 1 and Math.abs(tile.x - @x) < 1


  isMatch: (tile) ->
    return yes if @isSeason() and tile.isSeason()
    @type is tile.type


  isRemovable: ->
    openOnLeft = yes
    openOnRight = yes

    for tile in @game.tiles
      return no if tile.isCovering this
      continue unless tile.isAdjacent this

      openOnLeft = no if tile.x - @x is -1
      openOnRight = no if tile.x - @x is 1

    openOnLeft or openOnRight


  isSeason: ->
    @type in SEASONS


  remove: ->
    @el.remove()


  render: =>
    @el.appendTo @game.el


  select: =>
    @el.addClass 'selected'


  setType: (@type) ->
    @el.css backgroundImage: "url(./tiles/#{@type}.png)"



module.exports = Tile
