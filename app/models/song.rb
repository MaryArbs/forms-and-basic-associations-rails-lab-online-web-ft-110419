class Song < ActiveRecord::Base
  has_many :notes
  belongs_to :artist
  belongs_to :genre

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
     self.artist.name if self.artist
  end

  def genre_name=(genre)
    self.genre = Genre.find_or_create_by(name: genre)
  end

  def genre_name
     self.genre.name if self.genre
  end

  def note_contents
    self.notes.collect(&:content)
  end

  def note_contents=(note_contents)
    note_contents.map do |content|
      unless content.empty?
        self.notes << Note.create(content: content)
        self.save
      end
    end
  end
end
