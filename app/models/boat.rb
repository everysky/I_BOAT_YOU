class Boat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, :get_zipcode_from_geocoder, :get_town_from_geocoder, if: :will_save_change_to_address?
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true

  def get_zipcode_from_geocoder
    self.zip_code = Geocoder.search(address).first.data["address"]["postcode"] if address.present?
  end
  def get_town_from_geocoder
    self.city = Geocoder.search(address).first.data["address"]["city"] if address.present?
  end
end
