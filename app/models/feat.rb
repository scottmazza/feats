# == Schema Information
#
# Table name: feats
#
#  id             :integer         not null, primary key
#  location_id    :integer
#  description    :text
#  low_score_wins :boolean
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  user_id        :integer
#  name           :string(255)
#  timed          :boolean
#

class Feat < ActiveRecord::Base
  VALID_NAME_REGEXP = /\A\S+.*\S+\z/i

  belongs_to :user, inverse_of: :feats
  belongs_to :location, inverse_of: :feats
  has_many   :attempts
  has_many   :users, through: :attempts
  
  attr_accessible :user_id, :name, :description, :location_id, 
                  :low_score_wins, :timed
  
  validates :name, presence: true, format: { with: VALID_NAME_REGEXP }
  validates :description, presence: true
end

