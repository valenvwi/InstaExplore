class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :avatar
      t.string :bio
      t.string :location

      t.timestamps
    end
  end
end
