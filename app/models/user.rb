class User < ActiveRecord::Base
  has_one :person
  has_many :videos
  has_many :shows
  belongs_to :show
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :login, :advisor?, :person_attributes, :video_id, :show_id
  # attr_accessible :title, :body
  
  # Virtual attribut for authenticatingby either username or email
  attr_accessor :login
  
  
  
  def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  login = conditions.delete(:login).downcase
  where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
  
  def become_advisor
    self.advisor=true
    save!
   # puts "advisor should be true now"
   # puts advisor?
  end
  
  def normal_user
    self.advisor=false
    save!
   # puts "advisor should be false now"
   # puts advisor?
  end
  
  def self.all_advisors
    where(:advisor == true)
  end
      


end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#

