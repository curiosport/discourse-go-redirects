# frozen_string_literal: true

class GoRedirect < ActiveRecord::Base
  validates :slug,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "only letters, numbers, hyphens and underscores" }

  validates :destination,
            presence: true,
            format: { with: /\Ahttps?:\/\/.+/i, message: "must be a valid http/https URL" }

  before_save { self.slug = slug.downcase.strip }
end
