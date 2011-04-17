class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)

    puts "ENV IN FACEBOOK" + env["omniauth.auth"].to_s

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      session[:access_token] = env["omniauth.auth"]["credentials"]["token"]
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end
