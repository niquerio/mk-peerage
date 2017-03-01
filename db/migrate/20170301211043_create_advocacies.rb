class CreateAdvocacies < ActiveRecord::Migration[5.0]
  def change
    create_table :advocacies do |t|
      t.references :user, foreign_key: true
      t.references :candidate, foreign_key: true
      t.boolean :apprenticeship

      t.timestamps
    end
  end
end
