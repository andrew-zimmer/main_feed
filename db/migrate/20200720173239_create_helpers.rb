class CreateHelpers < ActiveRecord::Migration[6.0]
  def change
    create_table :helpers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :foremen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
