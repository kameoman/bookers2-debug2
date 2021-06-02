class RenamePostImageId < ActiveRecord::Migration[5.2]
  def change
    rename_column :post_comments , :post_image_id, :book_id
  end
end
