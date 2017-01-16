# # app/assets/javascripts/components/song.js.coffee

@Song = React.createClass
  getInitialState: ->
    song: @props.songData
    artist: @props.artistData
  getDefaultProps: ->
    song: ""
    artist: ""
  render: ->
    React.DOM.div
      className: 'song_holder'
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
            className: 'small-6 large-4 columns'
            id: i
            src: i
