class User < ActiveRecord::Base
  attr_accessible :email, :image, :name, :oath_provider, :oath_uid, :username
end
