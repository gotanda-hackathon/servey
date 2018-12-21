class AddIndexToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_index :customers, :email, unique: true
  end
end
