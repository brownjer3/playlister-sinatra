class Slugifiable

    def slug
        self.delete('^a-zA-Z0-9 .').split.join("-")
    end

end