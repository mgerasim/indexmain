class CreateVolumes < ActiveRecord::Migration[7.0]
  def change
    create_table :volumes do |t|
      t.integer :code
      t.integer :begin
      t.integer :end
      t.integer :size
      t.string :operator
      t.string :region
      t.string :unn

      t.timestamps
    end
  end
end
