class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :url
      t.timestamps
    end
  end
end
