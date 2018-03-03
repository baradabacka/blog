class CreateEntry < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :user
      t.string :caption
      t.string :content
      t.integer :autor_ip
    end
  end
end
