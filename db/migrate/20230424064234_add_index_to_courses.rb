class AddIndexToCourses < ActiveRecord::Migration[6.1]
  def change
    add_index :courses, :code
  end
end
