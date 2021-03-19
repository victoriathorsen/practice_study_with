class ChangeSchoolIdColumnToHaveNullInUser < ActiveRecord::Migration[6.1]
  def up
    change_column_null :users, :school_id, :integer, true
  end
end
