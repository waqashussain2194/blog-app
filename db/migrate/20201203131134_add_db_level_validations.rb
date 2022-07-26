class AddDbLevelValidations < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :title, :string
    remove_column :comments, :content, :text
    remove_column :suggestions, :content, :text

    add_column :posts, :title, :string, default: '', null: false
    add_column :comments, :content, :text, default: '', null: false
    add_column :suggestions, :content, :text, default: '', null: false
  end
end
