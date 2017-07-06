class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.belongs_to :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
