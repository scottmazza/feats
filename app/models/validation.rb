# == Schema Information
#
# Table name: validations
#
#  id         :integer         not null, primary key
#  attempt_id :integer
#  user_id    :integer
#  comment    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  rebuttal   :boolean         default(FALSE)
#

class Validation < ActiveRecord::Base
  attr_accessible :attempt_id, :comment, :user_id, :rebuttal
  belongs_to :attempt
  belongs_to :user
end

