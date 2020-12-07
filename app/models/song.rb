class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def slug
        name.downcase.delete('^a-zA-Z0-9 .').split.join("-")
    end

    def self.find_by_slug(slug)
        Song.all.find do |s|
            slug == s.slug
        end
    end
end