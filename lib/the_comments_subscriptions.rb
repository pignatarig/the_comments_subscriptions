_root_ = File.expand_path('../../',  __FILE__)

require "the_comments_subscriptions/version"

require 'the_encrypted_string'

module TheCommentsSubscriptions
  class Engine < Rails::Engine; end
end

# Routing cocerns loading
require "#{ _root_ }/config/routes"
