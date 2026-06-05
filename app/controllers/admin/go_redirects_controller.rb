# frozen_string_literal: true

module Admin
  class GoRedirectsController < Admin::AdminController
    def index
      redirects = GoRedirect.order(:slug).select(:id, :slug, :destination)
      render json: { redirects: redirects }
    end

    def create
      redirect = GoRedirect.new(
        slug:        params.require(:slug).strip,
        destination: params.require(:destination).strip,
      )

      if redirect.save
        render json: { redirect: redirect.slice(:id, :slug, :destination) }, status: :created
      else
        render json: { errors: redirect.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      redirect = GoRedirect.find(params[:id])
      redirect.destroy!
      render json: success_json
    end
  end
end
