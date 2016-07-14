class QuarkChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quark:quark_#{params[:scope]}"
  end

  def create(data)
    return unless current_user

    quark = Quark.new(count: data.count, user: current_user)
    if quark.save
      QuarkChannel.broadcast_to("quark_#{params[:scope]}", quark: quark, action: :created, status: :ok)
    else
      QuarkChannel.broadcast_to("quark_#{params[:scope]}", action: :created, status: :error)
    end
  end
end
