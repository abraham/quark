module ApplicationHelper
  # Determins the current version of the Rails app via GIT commit hash
  def current_app_version
    ENV['HEROKU_SLUG_COMMIT'] || 'edge'
  end
end
