class CounterController < ApplicationController
  helper CounterHelper

  before_action :require_login, only: [:create]

  def index
    @current_user = current_user
  end

  def create
    @quark = Quark.new(quark_params)
    @quark.user = current_user

    if @quark.save
      update_count_cache(@quark.count)
    else
      @quark.errors.full_messages.each do |message|
        flash[:error] = message
      end
    end

    redirect_to root_url
  end

  private

  def require_login
    return if current_user

    flash[:errors] = 'You must be signed in to count'
    redirect_to root_url
  end

  def quark_params
    params.require(:quark).permit(:count)
  end

  def update_count_cache(count)
    current_count = Rails.cache.fetch(:quark_count) { Quark.sum(:count) }
    Rails.cache.write(:quark_count, current_count + count)
  end
end
