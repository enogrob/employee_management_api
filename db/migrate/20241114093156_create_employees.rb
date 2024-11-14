class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :position
      t.string :department
      t.decimal :salary

      t.timestamps
    end
  end
end
