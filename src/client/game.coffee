class Game

  constructor: ->
    @tiles = []
    @selected = null


  addTile: (tile) ->
    tile.render()
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


  render: ->
    tile.render() for tile in @tiles


module.exports = Game
