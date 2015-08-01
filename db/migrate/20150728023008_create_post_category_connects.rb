class CreatePostCategoryConnects < ActiveRecord::Migration
  def change
    create_table :post_category_connects do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps
    end
  end
end
