class CreateCategoryLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :category_links do |t|
      t.integer :category_id
      t.integer :parent_id
      t.timestamps
    end
  end
end
