get '/posts' do
  @posts = Post.all.order(created_at: :desc)
  erb :"posts/index"
end

get '/posts/new' do
  authenticate
  @post = Post.new
  erb :"posts/new"
end

post '/posts' do
  authenticate
  @post = Post.new(title: params[:title], body: params[:body], user_id: current_user.id)

  if @post.save
    current_user.posts << @post
    redirect '/posts'
  else
    @errors = @post.errors.full_messages
    erb :"posts/new"
  end
end

get '/posts/:id' do
  @post = Post.find_by(id: params[:id])
  erb :"posts/show"
end

get '/posts/:id/edit' do
  authenticate
  @post = Post.find_by(id: params[:id])
  authorize(@post.user)
  erb :"posts/edit"
end

put '/posts/:id' do
  authenticate
  @post = Post.find_by(id: params[:id])
  authorize(@post.user)

  if @post.update(params[:post])
    redirect '/posts'
  else
    @errors = @post.errors.full_messages
    erb :"posts/edit"
  end
end

delete '/posts/:id' do
  authenticate
  @post = Post.find_by(id: params[:id])
  authorize(@post.user)
  @post.destroy
  redirect '/posts'
end

