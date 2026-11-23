require_relative "boot"
require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module LensOrderDesk
  # The demo uses Rails and server-rendered HTML with no frontend build step.
  class Application < Rails::Application
    config.load_defaults 8.1
    config.filter_parameters += %i[email customer]
  end
end
