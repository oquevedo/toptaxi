class CommentsController < ApplicationController
  protect_from_forgery except: :new_reply
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  def new_reply

    parent = Comment.find(params[:parent_comment_id])

    @comment = Comment.new
    @comment.blog = parent.blog

    if parent.parent_comment_id.nil?
      # si el supuesto padre, no tiene padre, es el
      @comment.parent_comment_id = parent.id
    else
      # si tiene, este comparte el mismo
      @comment.parent_comment_id = parent.parent_comment_id
      # y esta en respuesta a este comentario
      @comment.response_to_comment_id = parent.id
      # y a este usuario
      @comment.response_to_user_id = parent.user.id
    end

    respond_to do |format|
      format.js
      format.html { render partial: 'reply_form' }
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    # si vienen estos params... los seteamos al vuelo
    @comment.parent_comment_id = params[:comment][:parent_comment_id] if params[:comment][:parent_comment_id]
    @comment.response_to_comment_id = params[:comment][:response_to_comment_id] if params[:comment][:response_to_comment_id]
    @comment.response_to_user_id = params[:comment][:response_to_user_id] if params[:comment][:response_to_user_id]
    
    @comment.user = current_user

    if @comment.body != ""
      if @comment.save
        if @comment.parent_comment_id.nil?
          # redirect_to blog_path(@comment.blog), notice: 'Comment was successfully created.'
          render partial: 'comment_box'
        else
          # render json: @comment
          render partial: 'comment_box'
        end
      else
        # render :new
        redirect_to blog_path(@comment.blog)
      end 
    else
      # ver como devolver solo el notice
      # redirect_to blog_path(@comment.blog), notice: 'You must specify a comment.'
    end
    
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    blog = @comment.blog
    @comment.destroy
    
    redirect_to blog_path(blog), notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body, :blog_id)
    end
end
