class AddCommentsCountToMoviesAndSeries < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :comments_count, :integer, default: 0

    add_column :series, :comments_count, :integer, default: 0
  end
end
