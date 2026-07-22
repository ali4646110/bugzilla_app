class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title,null: false 

      t.timestamps
    end
    add_index :projects, :title, unique: true
  end
end
