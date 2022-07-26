class AddEnhancedDbValidations < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users_roles, :user_id, :bigint
    remove_column :users_roles, :role_id, :bigint
    remove_column :suggestions, :user_id, :bigint
    remove_column :suggestions, :post_id, :bigint
    remove_column :roles, :name, :string
    remove_column :reports, :user_id, :bigint
    remove_column :reports, :reportable_type, :string
    remove_column :reports, :reportable_id, :string
    remove_column :reactions, :user_id, :bigint
    remove_column :comments, :user_id, :bigint
    remove_column :comments, :commentable_type, :string
    remove_column :comments, :commentable_id, :bigint

    add_column :users, :first_name, :string, default: '', null: false
    add_column :users, :last_name, :string, default: '', null: false
    add_column :users_roles, :user_id, :bigint, default: 0, null: false
    add_column :users_roles, :role_id, :bigint, default: 0, null: false
    add_column :suggestions, :user_id, :bigint, default: 0, null: false
    add_column :suggestions, :post_id, :bigint, default: 0, null: false
    add_column :roles, :name, :string, default: '', null: false
    add_column :reports, :user_id, :bigint, default: 0, null: false
    add_column :reports, :reportable_type, :string, default: '', null: false
    add_column :reports, :reportable_id, :bigint, default: 0, null: false
    add_column :reactions, :user_id, :bigint, default: 0, null: false
    add_column :comments, :user_id, :bigint, default: 0, null: false
    add_column :comments, :commentable_type, :string, default: '', null: false
    add_column :comments, :commentable_id, :bigint, default: 0, null: false


  end
end
