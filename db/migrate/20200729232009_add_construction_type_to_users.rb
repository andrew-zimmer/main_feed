class AddConstructionTypeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :construction_type, :string
  end
end
