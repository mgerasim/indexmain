class AddFilenameIoutptToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :filename_ouutput, :string
  end
end
