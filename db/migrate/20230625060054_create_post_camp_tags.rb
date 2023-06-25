class CreatePostCampTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_camp_tags do |t|
      t.integer :post_camp_id, foreign_key: true, null: false
      t.integer :tag_id, foreign_key: true, null: false

      t.timestamps
    end
    #同じタグは2回保存できない
    add_index :post_camp_tags, [:post_camp_id,:tag_id], unique: true
  end
end
