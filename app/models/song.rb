class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :favorite_songs
  has_many :users, through: :favorite_songs

  BASE_URL = "http://ukulele-chords.com/get?"
  UKE_API_KEY = ENV["UKE_CHORDS_API_KEY"]

  def scrape_song(website)
    @page = HTTParty.get(website,
      headers: {
        'Cookie' => "__gads=ID=9076f852be57ecff:T=1477191925:S=ALNI_MZWYZcJNvsGTj85A7gFOZnoUO2HDg; __qca=P0-1944085700-1477191934000; position=1; userid=B5D0E0F3-7045-FB5C-25FB-9AD2062B43BE; OX_plg=swf|shk|pm; PHPSESSID=4492f7472b9af824196c58ca6da83cd8; scrollTop=0; cid=444; _ga=GA1.2.296721480.1477191925; __utmt=1; OX_sd=2; __utma=58811561.296721480.1477191925.1484947167.1484954896.58; __utmb=58811561.8.10.1484954897; __utmc=58811561; __utmz=58811561.1480827346.6.3.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)"
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
            # binding.pry

            @song_tab_string += change_sharp_to_flat( element.children.text ) + element.children.text[2..-1]
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
      mini_chord_pic_url = " " if mini_chord_pic_url == nil
      @chords_array.push(mini_chord_pic_url)
    end

    return @chords_array.join(" ")
  end

  def set_name_and_type(chord)
    # change those sharp chords to flats bc my API don't like em
    if chord[1] == "#"
      chord[0..1] = self.change_sharp_to_flat(chord[0..1])
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

    return chord_name, type
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
