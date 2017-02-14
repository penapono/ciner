# frozen_string_literal: true
module Admin
  class HomeController < AdminController
    expose(:events) { Event.all_next.first(4) }
    expose(:critics) { Critic.only_two }
    expose(:questions) { Question.top_questions }
  end
end
