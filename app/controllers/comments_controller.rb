class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    authorize @comments
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    #@comment = Comment.new
    @comment = current_user.comments.build
    authorize @comments
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
    @comment.save
    authorize @comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to post_path(@post), notice: "Comment must be 1-300 characters" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @post = Post.find(params[:post_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
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
