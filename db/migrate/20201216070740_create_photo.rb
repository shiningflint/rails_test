class CreatePhoto < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :title, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
