class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each do |post|
      @post = post
    end
  end

  def show; end
end
