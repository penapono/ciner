class CreateBroadcastProfessionals < ActiveRecord::Migration[5.1]
  def change
    create_table :broadcast_professionals do |t|  
      t.references :broadcast, index: false

      t.references :professional, index: false

      t.timestamps null: false
    end
  end
end
