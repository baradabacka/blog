class CreateEvaluation < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.references :entry
      t.integer :value
    end
  end
end
