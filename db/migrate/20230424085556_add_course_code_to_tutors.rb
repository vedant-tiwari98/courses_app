class AddCourseCodeToTutors < ActiveRecord::Migration[6.1]
  def change
    add_column :tutors, :course_code, :string
  end
end
