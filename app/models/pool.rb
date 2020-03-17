class Pool < ApplicationRecord
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
  include PgSearch::Model
   pg_search_scope :search_by_location_and_option,
    against: [:location, :option],
    using: {
      tsearch: { prefix: true }
    }

  belongs_to :user
  has_many :reviews

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

# def self.search(search)
#   if search
#     breed_type = Pool.find_by(option: search)
#     if breed_type
#       self.where(option: breed_type)
#     else
#       @pools = Pool.all
#     end
#   else
#     @pools = Pool.all
#   end
# end
  has_one_attached :photo
end
