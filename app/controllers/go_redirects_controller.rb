# frozen_string_literal: true

class GoRedirectsController < ApplicationController
  skip_before_action :check_xhr
  skip_before_action :verify_authenticity_token, raise: false
  skip_before_action :redirect_to_login_if_required, raise: false
  skip_before_action :check_second_factor_restrictions, raise: false

  def show
    redirect_rule = GoRedirect.find_by(slug: params[:slug]&.downcase)

    if redirect_rule
      redirect_to redirect_rule.destination, allow_other_host: true, status: :moved_permanently
    else
      raise Discourse::NotFound
    end
  end
end
