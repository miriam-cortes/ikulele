# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Ikulele::Application.configure do
  config.react.addons = true # defaults to false
end
