class ApplicationController < ActionController::Base
  # Include Pundit helper methods across all controllers
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps and css nesting
  allow_browser versions: :modern
end

