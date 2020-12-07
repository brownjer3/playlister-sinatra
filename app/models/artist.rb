class Artist < ActiveRecord::Base
    # extend Slugifiable

    has_many :songs
    has_many :genres, through: :songs

    def slug
        name.downcase.delete('^a-zA-Z0-9 .').split.join("-")
    end

    def self.find_by_slug(slug)
        Artist.all.find do |a|
            slug == a.slug
        end
    end

end