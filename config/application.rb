require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module InstaApp
  class Application < Rails::Application

    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.generators do |g|
      g.test_framework :rspec,
      fixtures: false,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end
