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
#  address    :string(255)
#

class Location < ActiveRecord::Base
  VALID_NAME_REGEXP = /\A[a-z\d]+.+[a-z\d\.]\z/i
  VALID_ADDRESS_REGEXP = /\A[a-z\d]+[\S ]+[a-z\d\.]\z/i

  belongs_to :user, inverse_of: :locations
  has_many :feats, inverse_of: :location
  
  attr_accessible :name, :address, :latitude, :longitude
  
  validates :name, presence: true, format: { with: VALID_NAME_REGEXP }
  validates :address, presence: true, format: { with: VALID_ADDRESS_REGEXP }
  validates :latitude, presence: true
  validates :longitude, presence: true 
  
  geocoded_by :address
  
end

