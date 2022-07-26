# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, :find_comment_parent
  before_action :set_comment, only: %i[edit update]

  def create
    @comment = @comment_parent.comments.build(comment_params)
    authorize @comment
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: t(:comment_creation_success)
    else
      redirect_to post_path(@post), alert: t(:comment_creation_error)
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: t(:comment_updation_success)
    else
      render 'edit', alert: t(:comment_updation_error)
    end
  end

  def destroy
    @comment = @comment_parent.comments.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: t(:comment_delete_success) }
        format.js
      end
    else
      redirect_to post_path(@post), alert: t(:comment_delete_error)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def find_comment_parent
    @post = Post.find(params[:post_id]) if params[:post_id]
    @comment_parent = Post.find(params[:post_id]) if params[:post_id]
    @comment_parent = Suggestion.find(params[:suggestion_id]) if params[:suggestion_id]
    @comment_parent = Comment.find(params[:comment_id]) if params[:comment_id]
  end
end
