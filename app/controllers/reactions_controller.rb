# frozen_string_literal: true

class ReactionsController < ApplicationController
  before_action :authenticate_user!, :find_reaction_parent

  def create
    @reaction = @reaction_parent.reactions.new(reaction_params)
    authorize @reaction
    @reaction.user_id = current_user.id

    if @reaction.save
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
    else
      redirect_to post_path(@post), alert: t(:reaction_create_error)
    end
  end

  def destroy
    @reaction = @reaction_parent.reactions.find_by(user_id: current_user.id)
    authorize @reaction
    if @reaction.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
    else
      redirect_to post_path(@post)
    end
  end

  protected

  def reaction_params
    params.permit(:reaction_type, :likeable_id, :likeable_type)
  end

  def find_reaction_parent
    @post = Post.find(params[:post_id]) if params[:post_id]
    @reaction_parent = Post.find_by(id: params[:post_id]) if params[:post_id]
    @reaction_parent = Comment.find_by(id: params[:comment_id]) if params[:comment_id]
  end
end
