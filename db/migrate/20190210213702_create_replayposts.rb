class CreateReplayposts < ActiveRecord::Migration[5.2]
  def change
    create_table :replayposts do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true

      t.timestamps
    end
  end
end
