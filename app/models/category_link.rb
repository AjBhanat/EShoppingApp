class CategoryLink < ApplicationRecord
  belongs_to :parent, :class_name => "Category"
end
