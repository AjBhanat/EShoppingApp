class Category < ApplicationRecord
  has_many :child_links, :class_name => 'CategoryLink', :foreign_key => 'parent_id'
  has_many :children, :through => :child_links
end
