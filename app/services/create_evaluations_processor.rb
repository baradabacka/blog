# frozen_string_literal: true

class CreateEvaluationsProcessor
  EVALUATION_KEY = 'create_evaluation'
  COLUMN_NAMES = %w(entry_id appraisal)

  attr_reader :redis, :ids

  def initialize
    @redis = Redis.current
    @ids = []
  end

  def run
    data = redis.spop(EVALUATION_KEY, redis.scard(EVALUATION_KEY))
    return if data.empty?
    perform_request(form_insert_data(data),
                    COLUMN_NAMES.map { |column| "excluded.#{column}"},
                    COLUMN_NAMES)
    update_entries_rating
  end

  private

  def form_insert_data(data)
    data.map do |r|
      row, uniq_key = r.split('!<>!')
      row = row.gsub!('|', ', ')
      ids << row[/\A\d+/]
      "(#{row})"
    end
  end

  def perform_request(insert_data, update_data, columns)
    query = "INSERT INTO evaluations (#{columns.join(', ')})" \
              " VALUES #{insert_data.join(', ')}" \
              " ON CONFLICT (id) DO UPDATE SET (#{columns.join(', ')}) = (#{update_data.join(', ')})"
    ActiveRecord::Base.connection.execute(query)
  end

  def update_entries_rating
    s = Time.now
    Entry.where(id: ids.uniq).each do |entry|
      entry.update rating: entry.evaluations.average(:appraisal)
    end
    puts Time.now - s
  end
end
