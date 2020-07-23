class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :issuer
      t.string :name
      t.timestamps
    end
  end
end
