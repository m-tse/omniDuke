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
  belongs_to :session
  has_many :bookbag_relationships
  has_many :courses, through: :bookbag_relationships, uniq: :true
  has_many :schedulator_saved_relationships
  has_many :schedulators, through: :schedulator_saved_relationships, uniq: true 
  has_many :active_schedulator_relationships
  has_many :active_schedulators, through: :active_schedulator_relationships, source: :schedulator, uniq: true
  has_one :current_schedulator, class_name: "Schedulator"
end
