# frozen_string_literal: true

class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.string :reaction_type, default: 'like'
      t.references :likeable, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
