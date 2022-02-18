class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user,   null: false, foreign_key: true
      t.integer :situation, null: false, default: 0, limit: 2
      t.text :text,         null: false
      t.string :caption

      t.timestamps
    end
  end
end
