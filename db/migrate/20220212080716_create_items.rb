class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :post,     null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :image
      t.string :name,         null: false
      t.string :manufacturer, null: false

      t.timestamps
    end
  end
end
