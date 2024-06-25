class ChangeUserIdNullConstraintInTickets < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tickets, :user_id, true
  end
end
