class AddNullFalseToNotesContent < ActiveRecord::Migration[5.1]
  def change
    change_column_null :notes, :content, false
  end
end
