class ChangeSchoolToCurrentSchool < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.rename :school, :current_school
    end
  end
end
