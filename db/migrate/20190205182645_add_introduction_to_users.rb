class AddIntroductionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :comment, :text
    add_column :users, :website, :string
    add_column :users, :phone_number, :string
    add_column :users, :sex, :string
  end
end
