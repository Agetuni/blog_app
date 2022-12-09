class PostsController < ApplicationController
  load_and_authorize_resource
  def create
    puts user_params
    post = Post.new(user_params, author: current_user)
    respond_to do |format|
      format.html do
        if post.save
          redirect_to user_posts_path(current_user.id), notice: 'Posted successfully'
        else
          flash[:notice] = 'Error: Not able to create post'
          render :new, locals: { post: }
        end
      end
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(author_id: params[:user_id])
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes(comments: [:author]).find(params[:id])
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def destroy
    post = Post.find(params[:id])
    user = User.find(post.author_id)
    post.destroy
    user.posts_counter -= 1
    user.save
    redirect_to user_url(user)
  end

  private

  def user_params
    params.require(:post).permit(:title, :text)
  end
end
