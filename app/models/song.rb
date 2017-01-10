class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :favorite_songs
  has_many :users, through: :favorite_songs

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

    return @chords, @song_tab_string, @header_array
  end

end
