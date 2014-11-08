# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	#attr_accessible :name,:email,:password,:password_confirmation
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	before_save { |user| user.email = email.downcase }
	validates(:name,presence:true,length:{maximum:50})
	validates(:email,presence:true,format:{with: VALID_EMAIL_REGEX},uniqueness:{case_sensitive:false})
	validates(:password,presence:true,length:{minimum:6})	
	validates(:password_confirmation,presence:true)
	
	#def initialize(attributes = {})
	 #   @name  = attributes[:name]
	  #  @email = attributes[:email]
	#end

	#def formatted_email
	 #   "#{@name} <#{@email}>"
	#end
end
