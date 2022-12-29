# frozen_string_literal: true

module Scores
  class UserDayScores < CachedComputer
    def get
      cache(Cache::UserDayScore) { compute }
    end

    private

    def cache_key
      @cache_key ||= [
        State.with_changes.maximum(:fetch_api_end)
      ].join("-")
    end

    RETURNED_ATTRIBUTES = %i[
      score day user_id part_1_completion_id part_2_completion_id
    ].freeze

    def compute
      points = Scores::SoloPoints.get

      grouped = points.group_by { |point| [point[:day], point[:user_id]] }
      grouped.filter_map do |(day, user_id), day_points|
        part_1 = day_points.find { |point| point[:challenge] == 1 }
        part_2 = day_points.find { |point| point[:challenge] == 2 }

        {
          score: day_points.pluck(:score).sum,
          day:,
          user_id:,
          part_1_completion_id: part_1&.fetch(:completion_id, nil),
          part_2_completion_id: part_2&.fetch(:completion_id, nil)
        }
      end
    end
  end
end