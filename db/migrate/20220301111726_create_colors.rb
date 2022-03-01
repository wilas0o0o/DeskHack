class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.references :post_image, foreign_key: true
      t.string :hex

      t.timestamps
    end
  end
end
