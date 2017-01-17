# # app/assets/javascripts/components/song.js.coffee

@Song = React.createClass
  getInitialState: ->
    song: @props.songData
    artist: @props.artistData
    my_favorite: @props.favoriteData
  getDefaultProps: ->
    song: ""
    artist: ""
    my_favorite: ""
  handleFavorite: ->
    console.log("current_favorite: " + @state.my_favorite)
    if @state.my_favorite == "❤️"
      $.ajax
        method: 'DELETE'
      @state.my_favorite == "♡"
      # FavoriteSong.find(user_id: current_user.id, song_id: @state.song.id).delete
      console.log("trying to delete favorite")
    if @state.my_favorite == "♡"
      console.log("trying to save favorite")
  render: ->
    React.DOM.div
      className: 'song_holder'
      React.DOM.h3
        className: 'small-1 columns favorite centered'
        id: 'favorite'
        onClick: @handleFavorite
        @state.my_favorite
      React.DOM.h2
        className: 'cursive-font small-6 columns'
        @state.song.name
      React.DOM.h2
        className: 'tabs small-8 large-8 columns'
        for i in @state.song.lyrics_tabs.split("|")
          React.DOM.p
            className: 'line'
            i
      React.DOM.div
        className: 'chords small-4 large-4 columns'
        for i in @state.song.sticky_tabs.split(" ")
          React.DOM.img
            className: 'small-6 large-4 columns '
            id: i
            src: i
