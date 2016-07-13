module ApplicationHelper
  def current_app_version
    ENV['HEROKU_SLUG_COMMIT'] || 'edge'
  end
end
