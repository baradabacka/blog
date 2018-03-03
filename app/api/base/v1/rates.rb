class Base::V1::Rates < Grape::API
  EVAL_COUNT = 'count_for_post_'
  EVAL_SUM = 'sum_for_post_'

  helpers do
    def redis
      @redis ||= Redis.current
    end

    def current_post
      @current_post ||= Post.find(params[:entry_id])
    end

    def eval_count
      key = [EVAL_COUNT, params[:entry_id]].join
      redis.setex(key, 3600, current_post.rates.count) unless redis.get(key)
      redis.incrby(key, 1)
    end

    def eval_sum
      key = [EVAL_SUM, params[:entry_id]].join
      redis.setex(key, 3600, current_post.rates.sum(:value)) unless redis.get(key)
      redis.incrby(key, params[:value].to_i)
    end

    def create_post
      redis.sadd(CreateEvaluationsProcessor::POST_KEY,
                 "#{current_post.id}|#{params[:value]}!<>!#{Time.now.to_f}")
    end
  end

  resource :evaluations do

    desc 'Add evaluation to post'
    params do
      requires :post_id
      requires :value, values: 1..5, description: 'range for value eq 1..5'
    end
    post do
      create_post
      { data: { average_rating: eval_sum.to_f / eval_count.to_f } }
    end
  end
end
