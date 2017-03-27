class AddUserToFilmables < ActiveRecord::Migration[5.0]
  def change
    add_reference :movies, :user, index: true

    add_reference :series, :user, index: true
  end
end
