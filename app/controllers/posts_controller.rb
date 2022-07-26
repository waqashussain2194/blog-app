# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy accept_post]

  def index
    @posts = Post.includes(:user).with_approval.order(created_at: :desc).page(params[:page])
    respond_to do |format|
      format.json { render json: @posts }
      format.html
    end
  end

  def new
    @post = current_user.posts.build
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post
    @post.approved = false
    @post.approved = true if @post.user.has_role?(:moderator) || @post.user.has_role?(:admin)
    if @post.save
      if @post.approved
        redirect_to @post, notice: t(:post_created)
      else
        redirect_to root_path, notice: t(:post_submission)
      end
    else
      redirect_to new_post_path, alert: t(:post_submission_error)
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @post }
      format.html
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t(:post_update)
    else
      render 'edit', alert: t(:post_update_error)
    end
  end

  def destroy
    if @post.destroy
      respond_to do |format|
        format.js   { flash[:notice] = 'Post Deleted Successfully!' }
        format.html { redirect_to root_path, notice: t(:post_delete_success) }
      end
    else
      render @post, alert: t(:post_delete_error)
    end
  end

  def profile
    authorize current_user
    @posts = Post.includes(:user).without_approval.order(created_at: :desc).page(params[:page])
    @all_posts = Post.all
  end

  def accept_post
    authorize current_user
    @post.approved = true
    @post.save
    redirect_to root_path, notice: t(:post_approval_success)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :approved)
  end

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end
end
