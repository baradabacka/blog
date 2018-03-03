class CreatePost < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.string :title, null: false
      t.string :text, null: false
      t.inet :autor_ip, null: false
    end
    Post.reset_column_information
    add_index :posts, :autor_ip
  end
end

