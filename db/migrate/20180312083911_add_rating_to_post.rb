class AddRatingToPost < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :rating, :decimal, precision: 1, scale: 1
    Post.reset_column_information
    add_index :posts, :rating
    Post.find_each do |post|
      post.update rating: post.rates.average(:value).to_i
    end
  end

  def down
    remove_column :posts, :rating
  end
end
