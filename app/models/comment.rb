class Comment < ActiveRecord::Base
	validates_presence_of :content
	belongs_to :user
	belongs_to :location

	def get_username
		User.find(self.user_id).username
	end

end