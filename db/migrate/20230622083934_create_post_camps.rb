class CreatePostCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :post_camps do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
