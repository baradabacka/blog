class Base::V1::Entries < Grape::API

  helpers do
    def current_user
      User.find_or_create_by!(login: params[:login])
    end
  end

  resource :entries do

    desc 'Top n Entries'
    params do
      requires :count, type: Integer
    end
    get 'top' do
      present  data: Entry.order(rating: :desc).select(:id, :caption, :content).first(params[:count].to_i)
    end

    desc 'Autor Ip'
    get 'autor_ip' do
      sql = 'SELECT DISTINCT entries.user_id, entries.autor_ip, users.login' \
             ' FROM entries INNER JOIN users ON users.id = entries.user_id' \
             ' WHERE autor_ip IN (SELECT entries.autor_ip FROM entries' \
             ' GROUP BY entries.autor_ip HAVING count(user_id)>1)'
      present data: Entry.find_by_sql(sql).group_by(&:autor_ip)
                         .each_with_object({}) { |array, result| result[array[0]] = array[1].pluck(:login) }
    end

    desc 'Create post', entity: Entity::Entry
    params do
      requires :autor_ip
      requires :login
      requires :caption
      requires :content
    end
    post do
      present current_user.entries.create!(safe_params.permit(:caption,
                                                              :content,
                                                              :autor_ip)), with: Entity::Entry
    end
  end
end