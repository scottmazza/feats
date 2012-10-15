class Validation < ActiveRecord::Base
  attr_accessible :attempt_id, :comment, :user_id
  belongs_to :attempt
  belongs_to :user
end
