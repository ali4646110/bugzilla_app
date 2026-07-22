class CreateBugs < ActiveRecord::Migration[8.1]
  def change
    create_table :bugs do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :status,null: false, default: "New"
      t.integer :creator_id, null: false
      t.integer :assignee_id

      t.timestamps
    end
    add_foreign_key :bugs, :users, column: :creator_id
    add_foreign_key :bugs, :users, column: :assignee_id
    
    # Indexes to make searching for bugs by creator or assignee lightning fast
    add_index :bugs, :creator_id
    add_index :bugs, :assignee_id
  end
end
