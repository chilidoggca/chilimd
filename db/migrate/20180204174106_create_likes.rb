class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
