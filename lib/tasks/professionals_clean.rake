namespace :professionals_clean do
  desc 'Clean Professionals'

  task unify_duplicates: :environment do
    FilmableProfessional.all.find_each do |fp|
      original_id = fp.id
      original_filmable_type = fp.filmable_type
      original_filmable_id = fp.filmable_id
      original_set_function_id = fp.set_function_id
      original_observation = fp.observation

      fps = FilmableProfessional
            .where("filmable_type = ? AND filmable_id = ? AND set_function_id = ? AND observation = ? AND (id <> ?)",
                   original_filmable_type, original_filmable_id, original_set_function_id, original_observation, original_id)

      unless fps.blank?
        fps.find_each do |possible_dup|
          if possible_dup.professional && fp.professional
            original_professional_id = fp.professional.id
            original_professional_name = fp.professional.name
            possible_dup_professional_id = possible_dup.professional.id
            possible_dup_professional_name = possible_dup.professional.name

            if original_professional_name == possible_dup_professional_name
              dup_fps = FilmableProfessional.where("professional_id = ?", possible_dup_professional_id)
              dup_fps.update_all(professional_id: original_professional_id) unless dup_fps.blank?

              professionals = Professional.where(id: possible_dup_professional_id)
              professionals.destroy_all if professionals
            end
          end
        end
      end
    end
  end

  task remove_duplicates: :environment do
    FilmableProfessional.all.find_each do |original|
      original_id = original.id
      original_professional_id = original.professional_id
      original_filmable_id = original.filmable_id
      original_filmable_type = original.filmable_type

      fps = FilmableProfessional
            .where("professional_id = ? AND filmable_id = ? AND filmable_type = ? AND id <> ?",
                   original_professional_id, original_filmable_id, original_filmable_type, original_id)

      fps.destroy_all unless fps.blank?
    end
  end
end
