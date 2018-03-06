class Base::V1 < Grape::API
  version 'v1', using: :path

  helpers Api::SafeParams

  prefix 'api'

  format :json

  rescue_from ActiveRecord::RecordNotFound do |_|
    rack_response({ error: 'Not found' }.to_json, 404, 'Content-type' => 'text/error')
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    rack_response({ error: e.record.errors.full_messages }.to_json, 422, 'Content-type' => 'text/error')
  end

  rescue_from ArgumentError do |e|
    rack_response({ error: e.message }.to_json, 422, 'Content-type' => 'text/error')
  end

  mount Entries
  mount Evaluations
end