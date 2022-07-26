# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!, :find_report_parent

  def create
    @report = @report_parent.reports.build(report_params)
    authorize @report
    @report.user = current_user
    if @report.save
      redirect_to post_path(@post), notice: t(:report_creation_success)
    else
      redirect_to post_path(@post), alert: t(:report_creation_error)
    end
  end

  def destroy
    @report = @report_parent.reports.find_by(user_id: current_user)
    authorize @report
    if @report.destroy
      redirect_to post_path(@post), notice: t(:report_undo)
    else
      redirect_to post_path(@post), alert: t(:report_undo_error)
    end
  end

  protected

  def report_params
    params.permit(:content, :reportable_id, :reportable_type)
  end

  def find_report_parent
    @post = Post.find(params[:post_id]) if params[:post_id]
    @report_parent = Post.find_by(id: params[:post_id]) if params[:post_id]
    @report_parent = Comment.find_by(id: params[:comment_id]) if params[:comment_id]
  end
end
