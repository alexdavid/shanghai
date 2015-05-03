class Game

  constructor: ->
    @tiles = []
    @selected = null


  addTile: (tile) ->
    tile.render()
    @tiles.push tile


  isRemovable: (testTile) ->
    openOnLeft = yes
    openOnRight = yes

    for tile in @tiles
      return no if tile.isCovering testTile
      continue unless tile.isAdjacent testTile

      openOnLeft = no if tile.x - testTile.x is -1
      openOnRight = no if tile.x - testTile.x is 1

    openOnLeft or openOnRight


  clickTile: (tile) ->

    if @selected is tile
      @selected.deselect()
      @selected = null
      return

    unless @isRemovable tile
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


  render: ->
    tile.render() for tile in @tiles


module.exports = Game
