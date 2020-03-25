class ReferenceStoredAsArrayInPostModel < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :references, :text, array: true, default: []
  end
end
