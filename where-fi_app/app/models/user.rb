class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username
  validates :first_name, :last_name, :numericality => false 
  has_secure_password

  has_and_belongs_to_many :locations

  def full_name
  	return self.first_name + " " + self.last_name
  end
  
end
