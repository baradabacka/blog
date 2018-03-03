class CreateRate < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.references :posts
      t.integer :value
    end
  end
end
