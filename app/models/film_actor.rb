class FilmActor < ApplicationRecord
  belongs_to :actor
  belongs_to :film
end
