class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :favorite_songs
  has_many :users, through: :favorite_songs

  BASE_URL = "http://ukulele-chords.com/get?"
  UKE_API_KEY = ENV["UKE_CHORDS_API_KEY"]

  def scrape_song(website)
    @page = HTTParty.get(website,
      headers: {
        'Cookie' => "PHPSESSID=b3ee7cb4c7d0973c4d2b6ab1b041eb2c; __gads=ID=99e96aca2d4d68e0:T=1488504907:S=ALNI_MYz3ybxLJcUw8zilCAO-bzllIGkWg; OX_plg=swf|shk|pm; __utmt=1; ut_keepin=mcortes8181%3A6ca3cec546966b3f8d76e41f9703344f; __utma=58811561.214000959.1488504759.1488504759.1488504759.1; __utmb=58811561.10.10.1488504759; __utmc=58811561; __utmz=58811561.1488504759.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); freewheel-detected-bandwidth=0"
      }
    )
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
          if element.children.text.include?("#")
            @song_tab_string += change_sharp_to_flat( element.children.text ) + element.children.text[2..-1]
            next
          else
            @song_tab_string += element.children.text
            next
          end
        end
      end
    else
      @song_tab_string += "sorry, details about this tab are not available."
    end

    @chords = ""

    (@parse_page.css('div#sticky_crd img')).each do |chord|
        @chords += chord['src'][25...-4] + ","
    end

    # @chords.gsub!("_","#") #questionable as to whether I need this anymore
    return @chords, @song_tab_string, @header_array
  end

  def split_chord_name_and_type(sticky_tabs)
    @chords_array = []
    sticky_tabs.split(",").each do |chord|
      @chords_array.push( self.set_name_and_type(chord) )
    end
    return @chords_array.join(" ")
  end

  def set_name_and_type(chord)
    updated_chord = ''
    # change those sharp chords to flats
    if chord[1] == "#"
      chord[0..1] = self.change_sharp_to_flat(chord[0..1])
    end
    # assign flat chord names/types
    if chord[1] == "b"
      updated_chord = chord[0..1]
      if chord.length == 2
        updated_chord += "major"
      elsif chord.length == 3 && chord[2] == "m"
        updated_chord += "minor"
      else
        updated_chord += chord[2..-1]
      end
    else
      updated_chord += chord[0]
      if chord.length == 1
        updated_chord += "major"
      elsif chord.length == 2 && chord[1] == "m"
        updated_chord += "minor"
      else
        updated_chord += chord[1..-1]
      end
    end
    return updated_chord
  end


  def change_sharp_to_flat(chord)
    case chord[0]
    when "C"
      return "Db"
    when "D"
      return "Eb"
    when "F"
      return "Gb"
    when "G"
      return "Ab"
    when "A"
      return "Bb"
    end
  end

end
