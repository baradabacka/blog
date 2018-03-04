class Base::V1::Evaluations < Grape::API

  helpers do
    def redis
      @redis ||= Redis.current
    end

    def current_post
      @current_post ||= Entry.find(params[:entry_id])
    end

    def check_appraisal
      params[:appraisal] = params[:appraisal].to_i
      error!('Bad Request', 400) unless (1..5).include?(params[:appraisal])
    end

    def create_post
      redis.sadd(CreateEvaluationsProcessor::EVALUATION_KEY,
                 "#{current_post.id}|#{params[:appraisal]}!<>!#{Time.now.to_f}")
    end
  end

  resource :evaluations do

    desc 'Add evaluation to post'
    params do
      requires :entry_id
      requires :appraisal, description: 'range for value eq 1..5'
    end
    post do
      check_appraisal
      create_post
      { data: { average_rating: current_post.evaluations.average(:appraisal) } }
    end
  end
end