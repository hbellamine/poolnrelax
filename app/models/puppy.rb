class Puppy < ApplicationRecord
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
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