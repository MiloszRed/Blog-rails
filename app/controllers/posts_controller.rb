#encoding: utf-8

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    if user_signed_in? && current_user.admin?
      redirect_to admin_posts_path
    end
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Posts: #{@posts.count}", template: "posts/index.html.erb", layout: 'pdf'   # Excluding ".pdf" extension.
      end
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Post id: #{@post.id}", template: "posts/show.html.erb", layout: 'pdf'   # Excluding ".pdf" extension.
      end
    end
  end

  # GET /posts/new
  def new
    #if current_user.admin
      @post = Post.new
    #else
     # redirect_to posts_path, notice: "Not Authorized User"
    #end 
  end

  # GET /posts/1/edit
  def edit
      redirect_to @post, notice: "Not Authorized User" 
  end

  def destroy
    #if current_user.admin
      @post.destroy
      respond_to do |format|
        format.html { redirect_to admin_posts_path, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    #else
      #redirect_to posts_url, notice: "Not authorized user"
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end
end
