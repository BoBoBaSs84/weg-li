class CreateBlueprints < ActiveRecord::Migration[8.1]
  def change
    create_table :blueprints do |t|
      t.string :name, null: false
      t.string :tbnr, null: true
      t.string :note, null: true
      t.integer :flags, null: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    change_table :notices do |t|
      t.references :blueprint, foreign_key: true, null: true
    end
  end
end
