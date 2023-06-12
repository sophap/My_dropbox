class AddColumnToDocks < ActiveRecord::Migration[7.0]
  def change
    add_column :docks, :format, :string
    add_column :docks, :docks, :string, default: "{}", array: true
  end
end
