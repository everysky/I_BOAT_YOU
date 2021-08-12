class Boat < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, :get_zipcode_from_geocoder, :get_town_from_geocoder, if: :will_save_change_to_address?

  def get_zipcode_from_geocoder
    self.zip_code = Geocoder.search(address).first.data["address"]["postcode"]
  end
  def get_town_from_geocoder
    self.city = Geocoder.search(address).first.data["address"]["city"]
  end
end
