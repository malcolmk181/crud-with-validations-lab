class Song < ApplicationRecord
    validates :title, length: { minimum: 1 }
    validates :artist_name, length: { minimum: 1 }


    validate :artist_cant_have_same_song_title_in_same_year, :released_requires_year

    private

    def artist_cant_have_same_song_title_in_same_year
        if Song.find_by(title: title, release_year: release_year)
            errors.add(:artist, "cannot have the same song title in the same year")
        end
    end

    def released_requires_year
        if released && (!release_year || release_year > Time.now.year)
            errors.add(:release_year, "must be less than or equal to #{Time.now.year} if released is true.")
        end
    end
end
