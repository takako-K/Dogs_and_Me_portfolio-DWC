class AddDefaultAlldayOfEvents < ActiveRecord::Migration[5.2]
  def change
    change_column_default :events, :allday, to: false
  end
end
