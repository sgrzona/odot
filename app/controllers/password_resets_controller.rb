class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver
      flash[:success] = "Password reset instructions sent! Please check your email."
      redirect_to login_path
    else
      flash.now[:notice] = "Email not found."
      render action: 'new'
    end
  end
end