# # app/assets/javascripts/components/song.js.coffee
pageScroll = ->
  divHeight = $('.tabs')[0].scrollHeight
  $('.tabs').animate({scrollTop: divHeight }, divHeight * 100, "linear")
  console.log("height: " + divHeight)

$(document).on "click", "#play", ->
  pageScroll()

$(document).on "click", "#stop", ->
  $('.tabs').stop()


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
        # if @state.my_favorite == " ❤️"
        #   console.log("It's a favorite")
        # else
        #   console.log("Not a favorite")
      React.DOM.h2
        className: 'cursive-font small-6 columns'
        @state.song.name
      React.DOM.h3
        className: 'small-1 columns skinny-font'
        id: 'play'
        "play!"
      React.DOM.h3
        className: 'small-1 columns skinny-font'
        id: 'stop'
        "stop!"
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
