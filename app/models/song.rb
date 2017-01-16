class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :favorite_songs
  has_many :users, through: :favorite_songs

  BASE_URL = "http://ukulele-chords.com/get?"
  UKE_API_KEY = ENV["UKE_CHORDS_API_KEY"]

  def scrape_song(website)
    @page = HTTParty.get(website)
    @parse_page = Nokogiri::HTML(@page)
    @header_array = @parse_page.css('h2').text.split(" Uke tab by ")
    @song_tab_string = ""
    @tab_section = @parse_page.css('pre').children

    if @tab_section.length != 0
      @tab_section.each do |element|
        if element.name == "text"
          if element.text.include?("  ")
            @song_tab_string += element.text.gsub("  ", " .")
          else
            @song_tab_string += ("|" + element.text + "|")
            next
          end
        elsif element.name == "a"
          @song_tab_string += element.children.text
          next
        # else
        #   @song_tab_string += element.name
        end
        # @song_tab_string += "|"
      end
    else
      @song_tab_string += "sorry, details about this tab are not available."
    end

    @chords = ""

    (@parse_page.css('div#sticky_crd img')).each do |chord|
        @chords += chord['src'][25...-4] + ","
    end
    @chords.gsub!("_","#")

    return @chords, @song_tab_string, @header_array
  end

  def get_chords_from_api(sticky_tabs)
    @chords_array = []

    sticky_tabs.split(",").each do |chord|
      chord_name, type = self.set_name_and_type(chord)

      url = BASE_URL + "ak=#{UKE_API_KEY}" + "&r=#{chord_name}" + "&typ=#{type}"
      response = HTTParty.get(url)
      mini_chord_pic_url = response.parsed_response["uc"]["chord"][0]["chord_diag_mini"]
      @chords_array.push(mini_chord_pic_url)
    end

    return @chords_array.join(" ")
  end

  def set_name_and_type(chord)
    # change those sharp chords to flats bc my API don't like em
    if chord[1] == "#"
      case chord[0]
      when "C"
        chord[0..1] = "Db"
      when "D"
        chord[0..1] = "Eb"
      when "F"
        chord[0..1] = "Gb"
      when "G"
        chord[0..1] = "Ab"
      when "A"
        chord[0..1] = "Bb"
      end
    end
    # assign flat chord names/types
    if chord[1] == "b"
      chord_name = chord[0..1]
      if chord.length == 2
        type = "major"
      elsif chord.length == 3 && chord[2] == "m"
        type = "minor"
      else
        type = chord[2..-1]
      end
    else
      chord_name = chord[0]
      if chord.length == 1
        type = "major"
      elsif chord.length == 2 && chord[1] == "m"
        type = "minor"
      else
        type = chord[1..-1]
      end
    end
    # raise


    return chord_name, type
  end

end
