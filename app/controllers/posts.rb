get '/posts' do
  @posts = Post.all
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

    p "inside POST /posts"
    p @post
  if @post.save
    p "inside if condition"
    p current_user
    p "***********************"

    current_user.posts << @post
    redirect '/posts'
  else
    p "inside else condition"
    p current_user
    @errors = @post.errors.full_messages
    p @errors
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

