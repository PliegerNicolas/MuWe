class AddingReferenceToPostModel < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :reference, :string
  end
end
