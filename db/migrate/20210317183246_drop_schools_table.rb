class DropSchoolsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :schools
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
