# frozen_string_literal: true

module ApplicationHelper
  def role?(role)
    current_user&.has_role?(role)
  end

  def post_owner?(post)
    current_user && post.user == current_user
  end

  def reaction_owner?(post)
    post.reactions.find_by(user_id: current_user.id)
  end

  def report_owner?(post)
    post.reports.find_by(user_id: current_user.id)
  end

  def suggestion_owner?(post)
    post.suggestions.find_by(user_id: current_user.id)
  end

  def get_post(post)
    Post.find(post.id)
  end

  def get_suggestion_owner(suggestion)
    User.find(suggestion.user_id)
  end

  def suggestion_given_by?(suggestion)
    suggestion.user == current_user
  end

  def get_suggestion_reply_user_name(sugg_reply)
    sugg_reply.user.first_name
  end

  def comment_owner?(comment)
    current_user == comment.user
  end
end
