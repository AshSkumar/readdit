class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.belongs_to :story, index: true, cache_counter: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
