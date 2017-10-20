require 'pry'
class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end
  def call
    input = ""

    if input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

    input = gets.strip
  case input
  when "list songs"
    list_songs
  when input = "list artists"
    list_artists
  when input = "list genres"
    list_genres
  when input = "list artist"
    list_songs_by_artist
  when input = "play song"
    play_song
  when input = "list genre"
    list_songs_by_genre
  else
    exit

end
end
end




  def list_songs
    Song.all.sort {|a,b| a.name.downcase<=>b.name.downcase}.each.with_index do |so, i|
      puts "#{i+1}. #{so.artist.name} - #{so.name} - #{so.genre.name}"

    end
  end

  def list_artists
    Artist.all.sort {|a,b| a.name<=>b.name}.each.with_index do |ar, i|
      puts "#{i+1}. #{ar.name}"

    end
  end

  def list_genres
    Genre.all.sort {|a,b| a.name<=>b.name}.each.with_index do |ge, i|
      puts "#{i+1}. #{ge.name}"

    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if artist = Artist.find_by_name(input)
      artist.songs.sort {|a,b| a.name.downcase <=> b.name.downcase}.each.with_index do |ar, i|
        #binding.pry
        puts "#{i+1}. #{ar.name} - #{ar.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort{ |a, b| a.name.downcase <=> b.name.downcase }.each.with_index do |ge, i|
        puts "#{i+1}. #{ge.artist.name} - #{ge.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
    song_count = Song.all.count
    if input.between?(1, song_count)
        puts "Playing #{song.name} by #{song.artist.name}"

end
end
end