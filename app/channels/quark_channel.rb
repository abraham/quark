class QuarkChannel < ApplicationCable::Channel
  def subscribed
    # Subscribe to all Quarks created
    stream_from 'quark:global'
    # Subscribe to specific API request responses
    stream_from "quark:#{self}"
  end

  # Allow the creation of Quarks via ActionCable
  def create(data)
    return unless current_user

    quark = Quark.new(count: data['count'], user: current_user)
    if quark.save
      success :global, :created, quark: quark, total_count: Quark.total_count
    else
      error self, :created, quark.errors.full_messages
    end
  end

  # Send the current Quark#total_count stats the client when requested
  def total_count
    success self, :total_count, total_count: Quark.total_count
  end

  private

  def success(channel, action, values)
    QuarkChannel.broadcast_to(channel, values.merge(action: action, status: :ok))
  end

  def error(channel, action, messages)
    QuarkChannel.broadcast_to(channel, action: action, status: :error, messages: messages)
  end
end
