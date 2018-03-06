class AddRatingToEntry < ActiveRecord::Migration[5.1]
  def up
    add_column :entries, :rating, :integer
    Entry.reset_column_information
    add_index :entries, :rating
    Entry.find_each do |entry|
      entry.update rating: entry.evaluations.average(:appraisal).to_i
    end
  end

  def down
    remove_column :entries, :rating
  end
end
