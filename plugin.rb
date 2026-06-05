# frozen_string_literal: true

# name: discourse-go-redirects
# about: Manage public short-link redirections within your Discourse forum
# version: 1.0.0
# authors: Willy
# url: https://github.com/your-org/discourse-go-redirects

enabled_site_setting :go_redirects_enabled

after_initialize do
  require_relative "app/models/go_redirect"
  require_relative "app/controllers/go_redirects_controller"
  require_relative "app/controllers/admin/go_redirects_controller"
  require_relative "lib/go_redirects_constraint"

  Discourse::Application.routes.prepend do
    get "/go/:slug", to: "go_redirects#show", constraints: GoRedirectsConstraint.new

    namespace :admin, path: "/admin" do
      resources :go_redirects, only: %i[index create destroy], path: "go-redirects"
    end
  end
end
