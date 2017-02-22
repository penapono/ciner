namespace :filmable_professional do

  desc 'Updates filmable_professionals'

  task create_or_update: :environment do

    FilmableProfessional.all.each do |fp|
      id = fp.filmable_type
      type = (Movie.where(id: id).any?) ? "Movie" : "Serie"
      fp.filmable_id = id
      fp.filmable_type = type
      puts "Funciona!" if fp.save
    end
  end
end
