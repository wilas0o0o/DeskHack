class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.references :post_id, foreign_key: true
      t.integer :red
      t.integer :green
      t.integer :blue

      t.timestamps
    end
  end
end
