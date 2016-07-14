class VersionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "version:#{self}"
  end

  def get
    VersionChannel.broadcast_to(self, version: current_app_version)
  end
end
