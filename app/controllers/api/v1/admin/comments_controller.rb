class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    #authorize @comments

    @post = Post.find(params[:post_id])
    render json: @post.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = current_user.comments.build
    #authorize @comments
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user if current_user 
    @comment.username = @comment.user.email.split('@')[0].capitalize
    authorize @comment

    if @comment.save
      render json: :show, status: :created, location: api_v1_post_comment_path(@comment)
    else
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @post = Post.find(params[:post_id])
    authorize @comment

    if @comment.update(comment_params)
      render json: :show, status: :ok, location: api_v1_post_comment_path(@comment) 
    else
      render json: @comment.errors, status: :unprocessable_entity 
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    head :no_content
  end

=begin
  def correct_user
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to post_path(@post), notice: "Not Authorized User" if @comment.nil?
  end
=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      authorize @comment
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:username, :body, :post_id, :user_id)
    end
end
