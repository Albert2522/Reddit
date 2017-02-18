class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    set_post
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.sub_id = [ ]
  end

  # GET /posts/1/edit
  def edit
    set_post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      post_params[:sub_id].each do |sub_id|
        post = PostSub.new(post_id: @post.id, sub_id: sub_id)
        post.save
      end
      debugger
      redirect_to sub_url(@post.sub_id)
    else
      flash[:error] = @post.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    set_post
      if @post.update(post_params)
        redirect_to sub_url(@post.sub_id)
      else
        flash[:error] = @post.errors.full_messages
        render :edit
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    set_post
    @post.destroy
    redirect_to posts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, :sub_id => [])
    end
end
