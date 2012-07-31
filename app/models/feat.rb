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
#

class Feat < ActiveRecord::Base
  belongs_to :user, inverse_of: :feats
  belongs_to :location, inverse_of: :feats
  has_many   :attempts
  has_many   :users, through: :attempts
  attr_accessible :creator_uid, :description, :location_id, :low_score_wins, :score
end

