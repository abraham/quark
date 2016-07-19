class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      flash[:notice] = greeting(@user.name)
      redirect_to root_url
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      redirect_to users_new_url
    end
  end

  private

  # Randomize the login greating for fun
  def greeting(name)
    [
      "Get counting #{name}!",
      "Hello #{name}!",
      "Hi #{name}!",
      "Welcome #{name}!"
    ].sample
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
