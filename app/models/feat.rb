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
  
  before_create :check_for_dup
  
  def self.count_by_user_id( user_id )
    count conditions: ["user_id=?", user_id ]
  end
  
  private
  
    def check_for_dup
      dup_not_found = true
      feats = Feat.find_all_by_location_id( self.location_id )
      
      feats.each do |f|
        if f.name.casecmp( self.name ) == 0
          dup_not_found = false;
          self.errors[:base] << "A feat by the same name exists at that location."
          break;
        end
      end
      dup_not_found
    end
end

