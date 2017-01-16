class CreateFilmableProfessionals < ActiveRecord::Migration
  def change
    create_table :filmable_professionals do |t|
      t.references :filmable, polymorphic: true, index: true
      t.references :professional, index: true
      t.references :set_function, index: true
      t.text :observation
    end
  end
end
