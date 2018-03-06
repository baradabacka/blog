module Entity
  class Entry < Grape::Entity
    root 'data', 'data'
    expose :id, documentation: { type: 'number' }
    expose :user_id, documentation: { type: 'integer', desc: 'Current user id' }
    expose :caption, documentation: { type: 'string', desc: 'Post Title' }
    expose :content, documentation: { type: 'string', desc: 'Content of the post' }
    expose :autor_ip, documentation: { type: 'integer', desc: 'Autor ip' }
  end
end
