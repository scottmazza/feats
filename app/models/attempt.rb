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
#  image      :string(255)
#

class Attempt < ActiveRecord::Base
  attr_accessible :feat_id, :score, :user_id, :video_url, :image
  belongs_to :user
  belongs_to :feat
  has_many :validations
  mount_uploader :image, ImageUploader
  validates :score, presence: true, numericality: true 
  
  # count_by_user_id
  #
  # Returns the number of attempts associated with the passed in user id.
  #
  def self.count_by_user_id( user_id )
    count conditions: ["user_id=?", user_id ]
  end
  
  # hhmmss_to_float
  #
  # Validates passed in hh, mm, and ss values, converts them to a float, and 
  # stores them in the 'score' field. Any errors will be written to :base
  #
  def hhmmss_to_score( hh, mm, ss )
    if hh.not_a_positive_int?
      self.errors[:base] << "Invalid 'Hours' value."
    end
    if mm.not_a_positive_int?
        self.errors[:base] << "Invalid 'Minutes' value."
    end
    if ss.not_a_positive_float?
        self.errors[:base] << "Invalid 'Seconds' value."
    end
    
    if self.errors.empty?
      self.score = hh.to_f * 3600.0 + mm.to_f * 60.0 + ss.to_f
      if self.score.zero?
        self.errors[:base] << "Attempt time must be non-zero."
      end
    end
  end  
  
  def location
    self.feat.location
  end
  
  def name
    self.feat.name
  end
end
