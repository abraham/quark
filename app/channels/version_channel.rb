# Long running web apps need to need to know when there is a new version.
# This channel will handle notifying clients when they are out of date.
class VersionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "version:#{self}"
  end

  # We only want to send the app version to the channel that requested it
  def get
    VersionChannel.broadcast_to(self, version: current_app_version)
  end
end
