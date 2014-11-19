class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates_presence_of :first_name, :last_name
  has_and_belongs_to_many :locations
  has_secure_password
end
