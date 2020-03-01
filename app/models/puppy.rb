class Puppy < ApplicationRecord
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
  include PgSearch::Model
   pg_search_scope :search_by_location_and_breed,
    against: [:location, :breed],
    using: {
      tsearch: { prefix: true }
    }

  belongs_to :user
  has_many :reviews

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

# def self.search(search)
#   if search
#     breed_type = Puppy.find_by(breed: search)
#     if breed_type
#       self.where(breed: breed_type)
#     else
#       @puppies = Puppy.all
#     end
#   else
#     @puppies = Puppy.all
#   end
# end
  has_one_attached :photo
end
