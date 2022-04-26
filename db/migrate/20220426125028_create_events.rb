class CreateEvents < ActiveRecord::Migration[5.0]
  def up
    create_table :events do |t|
      t.timestamps

      t.column :day, :integer, :null => false
      t.column :month, :integer, :null => false
      t.column :year, :integer
      t.column :name, :string, :null => false
    end
  end

  def down
    drop_table :events
  end
end
