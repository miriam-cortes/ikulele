# # app/assets/javascripts/components/song.js.coffee
pageScroll = (multiple = 1) ->
  divHeight = $('.tabs')[0].scrollHeight
  $('.tabs').animate({scrollTop: divHeight }, divHeight * 100 * multiple, "linear")

current_speed = 1

$(document).on "click", "#play", ->
  $('.tabs').stop()
  current_speed = 1
  console.log current_speed
  pageScroll(current_speed)

$(document).on "click", "#faster", ->
  $('.tabs').stop()
  current_speed *= 0.5
  console.log current_speed
  pageScroll(current_speed)

$(document).on "click", "#slower", ->
  $('.tabs').stop()
  current_speed *= 2
  console.log current_speed
  pageScroll(current_speed)

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
        className: 'cursive-font small-7 columns'
        @state.song.name
      React.DOM.h3
        className: 'small-1 columns skinny-font'
        id: 'play'
        "play!"
      React.DOM.h3
        className: 'small-1 columns skinny-font'
        id: 'stop'
        "stop!"
      React.DOM.h3
        className: 'small-1 columns skinny-font'
        id: 'faster'
        "faster"
      React.DOM.h3
        className: 'small-1 columns skinny-font'
        id: 'slower'
        "slower"
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
