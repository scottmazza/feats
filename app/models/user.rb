# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  email            :string(255)
#  name             :string(255)
#  username         :string(255)
#  image            :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  oauth_provider   :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :username, :image, :oauth_provider, 
                  :oauth_token, :oauth_expires_at
  
  before_save { |user| user.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[a-z\d\_]+/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, format: { with: VALID_USERNAME_REGEX }, 
                       uniqueness: { case_sensitive: false },
                       length: { maximum: 16 }, allow_nil: true, 
                       on: "update"
                    
  def profile_complete?
    if !@username
      false
    else
      true
    end
  end
end
