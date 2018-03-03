class Base::V1::Posts < Grape::API

  helpers do
    def current_user
      User.find_or_create_by!(login: params[:login])
    end
  end

  resource :posts do

    desc 'Top n Posts'
    params do
      requires :count, type: Integer
    end
    get 'top' do
      present  data: Post.order(rating: :desc).select(:id, :title, :text).first(params[:count].to_i)
    end

    desc 'Autor Ip'
    get 'autor_ip' do
      sql = 'SELECT DISTINCT posts.user_id, posts.autor_ip, users.login' \
             ' FROM posts INNER JOIN users ON users.id = posts.user_id' \
             ' WHERE autor_ip IN (SELECT posts.autor_ip FROM posts' \
             ' GROUP BY posts.autor_ip HAVING count(user_id)>1)'
      present data: Post.find_by_sql(sql).group_by(&:autor_ip)
                         .each_with_object({}) { |array, result| result[array[0]] = array[1].pluck(:login) }
    end

    desc 'Create post', entity: Entity::Post
    params do
      requires :autor_ip
      requires :login
      requires :text, type: String
      requires :title, type: String
    end
    post do
      present current_user.entries.create!(safe_params.permit(:text,
                                                              :title,
                                                              :autor_ip)), with: Entity::Post
    end
  end
end
