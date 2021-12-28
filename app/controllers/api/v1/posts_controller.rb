#encoding: utf-8

class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :require_admin

  # def require_admin
  #   unless api_v1_user_signed_in? && !current_api_v1_user.admin?
  #       redirect_to root_path, notice: "You are not authorized to perform this action."
  #   end
  # end

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    #authorize @posts

    render json: @posts, methods: [:image_urls]
  end

  # GET /posts/1 or /posts/1.json
  def show
    render json: @post
  end

  # GET /posts/new
  # def new
  #   #if current_user.admin
  #     @post = Post.new
  #     #authorize @post
  #   #else
  #    # redirect_to posts_path, notice: "Not Authorized User"
  #   #end 
  # end

  def create
    @post = Post.new(post_params)
    authorize @post

    if @post.save
      render json: @post, status: :created, location: api_v1_posts_path(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @post

    if @post.update(post_params)
      render json: @post, status: :ok, location: api_v1_posts_path(@post) 
    else
      render json: @post.errors, status: :unprocessable_entity 
    end
  end

  def destroy 
    authorize @post
    @post.destroy
    if @response
      render json: @response
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, images: [])
    end

end
