# frozen_string_literal: true

module ExtendedContainerHelper
  def extended_container?
    extended_controllers =
      %w[
        movies series
        admin/movies admin/series
        platform/movies platform/series
        curriculums
        admin/curriculums platform/curriculums
        ciner_productions
        admin/ciner_productions platform/ciner_productions
      ]

    extended_actions = %w[show]

    (extended_controllers.include? controller_path) &&
      (extended_actions.include? action_name)
  end
end
