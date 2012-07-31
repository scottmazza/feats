# == Schema Information
#
# Table name: locations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  address    :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

class Location < ActiveRecord::Base
  belongs_to :user, inverse_of: :locations
  has_many :feats, inverse_of: :location
  attr_accessible :address, :creator_uid, :latitude, :longitude, :name
  geocoded_by :address
  after_validation :geocode
end

