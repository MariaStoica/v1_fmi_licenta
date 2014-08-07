class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :nume
      t.string :prenume
      t.string :rol
      t.integer :grupa
      t.string :grad
      t.boolean :este_eligibil_licenta
      t.string :token

      t.timestamps
    end
    add_index :users, :token
    add_index :users, :email, unique: true
  end
end
