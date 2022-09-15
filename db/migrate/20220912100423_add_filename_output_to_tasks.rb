class AddFilenameOutputToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :filename_output, :string
  end
end
