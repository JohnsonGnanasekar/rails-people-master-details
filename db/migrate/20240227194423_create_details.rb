class CreateDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :details do |t|
      t.references :person, null: false, foreign_key: true
      t.string :detail_type, null: false
      t.string :detail_value

      t.timestamps
    end
  end
end
