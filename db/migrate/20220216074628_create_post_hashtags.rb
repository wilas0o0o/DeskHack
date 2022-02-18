class CreatePostHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_hashtags do |t|
      t.references :post,    foreign_key: true
      t.references :hashtag, foregin_key: true

      t.timestamps
    end
  end
end
