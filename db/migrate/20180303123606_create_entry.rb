class CreateEntry < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :user
      t.string :caption, null: false
      t.string :content, null: false
      t.integer :autor_ip, null: false
    end
    Entry.reset_column_information
    add_index :entries, :autor_ip
  end
end
