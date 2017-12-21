class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :subject
      t.timestamps
    end

    add_index :topics, :subject
  end
end
