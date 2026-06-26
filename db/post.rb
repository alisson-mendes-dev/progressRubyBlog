

class Post 
    include Mongoid::Document
    include Mongoid::Timestamps # Isso cria os campos created_at e updated_at

    field :titulo, type: String
    field :conteudo, type: String
    field :referencia, type: String
end