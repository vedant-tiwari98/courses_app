class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
