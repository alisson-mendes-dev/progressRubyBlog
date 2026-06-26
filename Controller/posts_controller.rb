require_relative '../db/post'

get '/' do
  # Pega o número da página da URL (ex: /?page=2), padrão é 1
  @page = (params[:page] || 1).to_i
  @per_page = 6
  
  # Lógica: Se página é 1, pula 0. Se página é 2, pula 6, etc.
  @posts = Post.all.limit(@per_page).skip((@page - 1) * @per_page).order_by(created_at: :desc)
  
  # Calcula total para saber se deve mostrar o botão "Próxima"
  @total_pages = (Post.count.to_f / @per_page).ceil
  
  erb :index
end

get '/posts/:id' do

  id_post = params[:id]
  post_encontrado = Post.find(id_post)

  post_encontrado.to_json

rescue Mongoid::Errors::DocumentNotFound

  status 404

  {
    erro: "Post não encontrado"
  }.to_json

end

get '/login' do
  erb :login
end

post '/login' do

  if params[:username] == ENV['ADMIN_USER'] &&
     params[:password] == ENV['ADMIN_PASSWORD']

    session[:admin] = true

    redirect '/admin'
  else
    @erro = "Usuário ou senha inválidos"
    erb :login
  end

end

get '/logout' do
  session.clear
  redirect '/login'
end

get '/search' do
  query = params[:q]
  
  # Se query estiver vazia ou nula, retorna tudo
  if query.nil? || query.empty?
    @posts = Post.all.order_by(created_at: :desc)
  else
    # Busca parcial com case-insensitive
    @posts = Post.where(titulo: /#{Regexp.escape(query)}/i).order_by(created_at: :desc)
  end
  
  erb :_posts_list, layout: false
end