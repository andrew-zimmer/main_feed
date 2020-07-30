class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :address
      t.integer :project_number
      t.datetime :start_date
      t.datetime :end_date
      t.string :construction_type
      t.boolean :finish, default: false
      t.boolean :started, default: false

      t.timestamps
    end
  end
end
