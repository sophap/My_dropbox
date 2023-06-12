class CreateDocks < ActiveRecord::Migration[7.0]
  def change
    create_table :docks do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
