class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.references :post_image, foreign_key: true
      t.string :hex,            null: false
      t.float :pixel_fraction,  null: false

      t.timestamps
    end
  end
end
