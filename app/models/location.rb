# == Schema Information
#
# Table name: locations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#  street     :string(255)
#  city       :string(255)
#  state      :string(255)
#  zipcode    :string(255)
#

class Location < ActiveRecord::Base
  VALID_NAME_REGEXP = /\A[a-z\d]+[a-z \'\d\-\.,]+[a-z\d\.]\z/i
  VALID_STREET_REGEXP = /\A[a-z\d]+[a-z \d\-\.,]+[a-z\d\.]\z/i
  VALID_CITY_REGEXP = /\A[a-z]+[a-z\-\s.]+\z/i
  VALID_STATE_REGEXP = /\A[a-z]{2}\z/i
  VALID_ZIPCODE_REGEXP = /\A[0-9]{5}\z/

  belongs_to :user, inverse_of: :locations
  has_many :feats, inverse_of: :location
  
  attr_accessible :name, :street, :city, :state, :zipcode, :latitude,
                  :longitude
  
  validates :name, presence: true, format: { with: VALID_NAME_REGEXP }
  validates :street, presence: true, format: { with: VALID_STREET_REGEXP }
  validates :city, presence: true, format: { with: VALID_CITY_REGEXP }
  validates :state, presence: true, format: { with: VALID_STATE_REGEXP }
  
  before_save { |location| location.state = state.upcase }
  
  validates :zipcode, presence: true, format: { with: VALID_ZIPCODE_REGEXP }
  
  geocoded_by :full_street_address
  validate :geocode, if: :latitude_and_longitude_are_nil?
  
  validate  :latitude_and_logitude_cannot_be_nil
  
  def full_street_address
    self.street + ", " + self.city + ", " + self.state + ", " + self.zipcode
  end
  
  def latitude_and_logitude_cannot_be_nil
    if self.latitude.nil? || self.longitude.nil?
      errors[:base] << "Address cannot be located."
    end
  end
  
  def latitude_and_longitude_are_nil?
    self.latitude.nil? && self.longitude.nil?
  end
end

