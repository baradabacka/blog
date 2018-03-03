module Entity
  class Post < Grape::Entity
    root 'data', 'data'
    expose :id, documentation: { type: 'number' }
    expose :user_id, documentation: { type: 'integer', desc: 'Current user id' }
    expose :title, documentation: { type: 'string', desc: 'Post Title' }
    expose :text, documentation: { type: 'string', desc: 'Content of the post' }
    expose :autor_ip, documentation: { type: 'integer', desc: 'Autor ip' }
  end
end
