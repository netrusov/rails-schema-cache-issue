class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.virtual :full_name, type: :text, as: "first_name || ' ' || last_name", stored: true

      t.timestamps
    end
  end
end
