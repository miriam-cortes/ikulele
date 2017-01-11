class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :favorite_songs
  has_many :users, through: :favorite_songs

  BASE_URL = "ukulele-chords.com/get?"
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
            @song_tab_string += element.text
          end
        elsif element.name == "a"
          @song_tab_string += element.children.text
        else
          @song_tab_string += element.name
        end
        @song_tab_string += "|"
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
    # url = BASE_URL + "ak=#{UKE_API_KEY}" + "&r=#{chord}" + "&typ=#{type}"
    # data = HTTParty.get(url)
    @chords_array = []

    sticky_tabs.split(",").each do |chord|
      case chord[0..1]
      when "Ab"
      end
        raise
      @chords_array.push()
    end

    return @chords_array
  end

end
