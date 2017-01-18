# # app/assets/javascripts/components/song.js.coffee
pageScroll = () ->
  $('.tabs').animate({scrollTop: 10000000}, 10000000)

$(document).on "click", "#play", ->
  console.log("scrolling!!")
  pageScroll()


@Song = React.createClass
  getInitialState: ->
    song: @props.songData
    my_favorite: @props.favoriteData
  getDefaultProps: ->
    song: ""
    artist: ""
    my_favorite: ""
  render: ->
    React.DOM.div
      className: 'song_holder'
      React.DOM.h3
        className: 'small-1 columns favorite centered'
        id: 'favorite'
        @state.my_favorite
        if @state.my_favorite == " ❤️"
          console.log("It's a favorite")
        else
          console.log("Not a favorite")
      React.DOM.h2
        className: 'cursive-font small-6 columns'
        @state.song.name
      React.DOM.h3
        className: 'small-1 columns skinny-font'
        id: 'play'
        "play!"
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
