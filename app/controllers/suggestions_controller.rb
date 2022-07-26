# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :find_post, only: %i[create destroy]

  def new; end

  def create
    @suggestion = @post.suggestions.build(suggestion_params)
    authorize @suggestion
    if @suggestion.save
      redirect_to post_path(@post), notice: t(:suggestion_success)
    else
      redirect_to post_path(@post), alert: t(:suggestion_error)
    end
  end

  def show; end

  def destroy
    @suggestion = Suggestion.find_by(post_id: @post.id)
    authorize @suggestion
    if @suggestion.destroy
      redirect_to post_path(@post), notice: t(:suggestion_rejection)
    else
      render @post, alert: t(suggestion_destroy_error)
    end
  end

  def accept
    @suggestion = Suggestion.find(params[:format])
    authorize @suggestion
    @post = @suggestion.post

    if @suggestion.content.include? ':'
      text_before = @suggestion.content.split(':')[0]
      text_after = @suggestion.content.split(':')[1]

      if @post.content.gsub(text_before, text_after)
        new_desc = @post.content.gsub(text_before, text_after)
        @post.content = new_desc
        @post.save
        msg = t(:suggestion_accept)
      else
        msg = t(:suggestion_msg)
      end
    else
      msg = t(:suggestion_not_implemented)
    end
    if @suggestion.destroy
      redirect_to @post, notice: msg
    else
      render @post, alert: t(:suggestion_error)
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:user_id, :content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
