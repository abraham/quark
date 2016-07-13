class VersionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "version:#{self}"
  end

  def get
    VersionChannel.broadcast_to(self, sha1: current_app_version)
  end
end
