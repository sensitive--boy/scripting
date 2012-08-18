class Technician < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :username
  # attr_accessible :title, :body
  
  # Virtual attribut for authenticatingby either username or email
  attr_accessor :login
  
  def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  login = conditions.delete(:login).downcase
  where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
end
