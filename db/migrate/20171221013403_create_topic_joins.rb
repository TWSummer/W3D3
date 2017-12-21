class CreateTopicJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :topic_joins do |t|
      t.integer :url_id, null: false
      t.integer :topic_id, null: false
      t.timestamps
    end

    add_index :topic_joins, :url_id
    add_index :topic_joins, :topic_id
  end
end
