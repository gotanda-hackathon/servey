class AddLoginCodeToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :customers, :login_code, :string
    add_column :customers, :point, :integer
  end
end
