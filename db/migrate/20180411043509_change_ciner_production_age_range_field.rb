class ChangeCinerProductionAgeRangeField < ActiveRecord::Migration[5.1]
  def change
    remove_column :ciner_productions, :age_range_id
    add_reference :ciner_productions, :age_range, index: true
  end
end
