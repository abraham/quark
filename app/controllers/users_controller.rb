class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # We don't really care about security here, just that actions have a name to display
    @user = find_user(params['user']['name']) || User.new(user_params)

    if @user.save
      sign_in @user
      flash[:notice] = greeting(@user.name)
      redirect_to root_url
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      redirect_to new_users_url
    end
  end

  private

  def find_user(name)
    User.lower_name(name).first
  end

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
