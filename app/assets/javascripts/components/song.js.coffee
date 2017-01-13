# # app/assets/javascripts/components/song.js.coffee

@Song = React.createClass
  getInitialState: ->
    song: @props.songData
    artist: @props.artistData
  getDefaultProps: ->
    # song: ""
    artist: ""
  render: ->
    React.DOM.div
      className: 'song_holder'
      React.DOM.h2
        className: 'cursive-font'
        @state.song.name
      React.DOM.h2
        className: 'skinny-font'
        @state.artist.name
      React.DOM.h2
        className: 'tabs small-7 large-9 columns'
        @state.song.lyrics_tabs
      React.DOM.div
        className: 'tabs small-4 large-3 columns'
        for i in @state.song.sticky_tabs.split(" ")
          React.DOM.img
            className: 'small-6 columns'
            id: i
            src: i



# @Artist = React.createClass
#   getInitialState: ->
#     artist: @props.data
#   render: ->
#     React.DOM.div
#       className: 'artist'
#       # React.DOM.h2
#       #   className: 'cursive-font'
#       #   @state.song.name
#       React.DOM.h2
#         className: 'cursive-font'
#         @state.artist.name
