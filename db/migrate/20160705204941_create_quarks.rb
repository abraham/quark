class CreateQuarks < ActiveRecord::Migration[5.0]
  def change
    create_table :quarks do |t|
      t.integer :count
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
