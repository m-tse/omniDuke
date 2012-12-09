class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #a user must always have a current session he/she is browsing to/from
  validates :session, presence:true

  before_validation do
    if(self.session==nil)
      self.session=Session.find_by_name("fall2012"); #eventually change this to a default global constant
    end
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
    belongs_to :session
end
