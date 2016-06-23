class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_date
      t.string :event_location
      t.string :event_state
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
