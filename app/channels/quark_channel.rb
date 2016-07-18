class QuarkChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'quark:global'
    stream_from "quark:#{self}"
  end

  def create(data)
    return unless current_user

    quark = Quark.new(count: data['count'], user: current_user)
    if quark.save
      QuarkChannel.broadcast_to(:global, quark: quark, action: :created, status: :ok)
    else
      QuarkChannel.broadcast_to(self, action: :created, status: :error, messages: quark.errors.full_messages)
    end
  end

  def total_count
    QuarkChannel.broadcast_to(self, action: :total_count, status: :ok, count: Quark.total_count)
  end
end
