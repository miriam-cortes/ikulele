class HomepagesController < ApplicationController
  def index
  end

  def search_results
    data = HTTParty.get('http://www.ukulele-tabs.com/search-uke-chords.html?find=beatles')
    @parse_search_results = Nokogiri::HTML(data)
    @the_part_i_need = @parse_search_results.css('#content')

    ##artist results
    @artists = @the_part_i_need.children[0]
    @artist_link_array = [] #array of arrays with artist name as [0] and link as [1]
    @number_artist_results = @artists.children[1].children[3].text #number of artists
    @the_part_i_need.children[6].children.each do |artist|
      if artist.name == "a"
        @artist_link_array.push( [artist.children[0].text,artist.attributes.values[0].value] )
      end
    end

    ##song results
    @songs = @the_part_i_need.children[9]
    @songs_list_array = []
    @number_song_results = @the_part_i_need.children[7].children[3].children[0].text
    @songs.children.each do |element|
      if element.name == "li"
        @songs_list_array.push( [element.children[4].children[0].text,element.children[4].attributes.values[0].value] )
      end
    end

    ##albums results
    @albums = @the_part_i_need.children[12]
    @albums_link_array = []
    @number_album_results = @the_part_i_need.children[10].children[3].children[0].text
    @albums.children.each do |element|
      if element.name == "a"
        @albums_link_array.push(element.children[0].text,element.attributes.values[0].value)
      end
    end
  end

  def song
    
  end

  def artist
  end

  def album
  end

  def random
  end

  def chord_bank
  end

  def favorites
  end
end
