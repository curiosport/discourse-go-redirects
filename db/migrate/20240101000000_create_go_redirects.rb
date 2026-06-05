# frozen_string_literal: true

class CreateGoRedirects < ActiveRecord::Migration[7.0]
  def change
    create_table :go_redirects do |t|
      t.string :slug,        null: false
      t.string :destination, null: false
      t.timestamps
    end

    add_index :go_redirects, :slug, unique: true
  end
end
