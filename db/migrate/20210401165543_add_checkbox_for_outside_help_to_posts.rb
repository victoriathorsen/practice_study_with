class AddCheckboxForOutsideHelpToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :public, :boolean
  end
end
