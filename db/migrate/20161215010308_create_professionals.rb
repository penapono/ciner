class CreateProfessionals < ActiveRecord::Migration
  def change
    create_table :professionals do |t|
      # User Attributes
      t.string :name
      t.integer :gender
      t.string :nickname
      t.date :birthday
      t.integer :age
      t.string :cep
      t.string :address
      t.string :number
      t.string :neighbourhood
      t.string :complement
      t.string :cpf
      t.string :phone
      t.string :mobile
      t.string :avatar
      t.text :biography

      t.references :city, index: true
      t.references :state, index: true
      t.references :country, index: true

      # Professional Attributes
      t.references :set_function

      # If Professional is an User
      t.references :user

      t.timestamps null: false
    end
  end
end
