class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :helpers, :foremen_id, :foreman_id
  end
end
