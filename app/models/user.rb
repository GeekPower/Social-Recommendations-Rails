class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me

  has_many :links

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    # Get the user email info from Facebook for sign up
    # You'll have to figure this part out from the json you get back



    #data = ActiveSupport::JSON.decode(access_token.to_s)

    if user = User.find_by_email(access_token["user_info"]["email"])
      user
    else
      # Create an user with a stub password.
      User.create!(:name => access_token["user_info"]["name"], :email => access_token["user_info"]["email"], :password => Devise.friendly_token)
    end


  #def self.new_with_session(params, session)
  #  super.tap do |user|
  #    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
  #      user.email = data["email"]
  #    end
  #  end
  #end

  end
end
