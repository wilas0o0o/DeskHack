class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false ,foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :post_id], unique: true
    end
  end
end
