class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :text,         null: false
      t.integer :situation, null: false, default: 0, null: false, limit: 2
      t.references :user,   null: false, foreign_key: true

      t.timestamps
    end
  end
end
