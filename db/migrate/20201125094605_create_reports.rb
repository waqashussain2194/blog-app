# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :reportable, polymorphic: true
      t.text :content
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
