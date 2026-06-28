class AdminController < Sinatra::Base

  set :views,
            File.expand_path('../../views', __FILE__)

  enable :sessions

  helpers AuthHelper

  get '/admin' do
    authenticate!

    erb :admin
  end

  get 'admin/posts' do
    authenticate!

    content_type :json

    Post.all.to_json
  end

end

# Criar - Exibe formulário
  get '/admin/posts/new' do
    authenticate!
    erb :new_post
  end

# Salvar Novo Post
  post '/admin/posts' do
    authenticate!
    Post.create(
      titulo: params[:titulo], 
      conteudo: params[:conteudo],
      referencia: params[:referencia]
    )
    redirect '/admin'
  end

  # Atualizar Post Existente

  put '/admin/posts/:id' do
  authenticate! # Se você usa autenticação
  
  post = Post.find(params[:id])
  if post.update(titulo: params[:titulo], conteudo: params[:conteudo], referencia: params[:referencia])
    redirect '/admin'
  else
    # Caso dê erro, você pode tratar aqui
    "Erro ao atualizar o post."
  end
end

  # Excluir
  post '/admin/posts/:id/delete' do
    authenticate!
    Post.find(params[:id]).destroy
    redirect '/admin'
  end

# No seu controller (ex: admin_controller.rb)
get '/admin/posts/:id/edit' do 
  authenticate! # Garante que só admin acesse
  @post = Post.find(params[:id]) # Busca o post pelo ID da URL
  erb :edit # Carrega o arquivo edit.erb que criamos acima
end