# == Schema Information
#
# Table name: attempts
#
#  id         :integer         not null, primary key
#  feat_id    :integer
#  user_id    :integer
#  score      :float
#  video_url  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat
  attr_accessible :feat_id, :score, :user_id, :video_url
end
