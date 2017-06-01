class AddStateToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :state, index: true
  end
end
