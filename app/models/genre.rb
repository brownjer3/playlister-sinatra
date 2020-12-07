class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def slug
        name.downcase.delete('^a-zA-Z0-9 .').split.join("-")
    end

    def self.find_by_slug(slug)
        Genre.all.find do |g|
            slug == g.slug
        end
    end

end