# frozen_string_literal: true

class Api::V1::CommentsController < ApplicationController
  include ::BaseController

  PER_PAGE = 10

  PERMITTED_PARAMS = %i[
    user_id commentable_type commentable_id content status
    origin spoiler featured commentable user
  ].freeze

  expose(:comment) { resource }
  expose(:comments) { filter_comments }

  # actions

  def index
    # self.comments = filter_comments
    render partial: 'index', layout: false
  end

  def create
    render_json_object_result(comment.save)
  end

  def destroy
    render_json_object_result(comment.destroy)
  end

  def comment
    @comment ||= resource
  end

  def resource
    find_action? ? find_resource : new_resource
  end

  def find_resource
    Comment.find(params[:id])
  end

  def new_resource
    comment = Comment.new(comment_params)
  end

  def filter_comments
    return Comment.none if params[:commentableId].empty? || params[:commentableType].empty?
    commentable_id = params[:commentableId]
    commentable_type = params[:commentableType]

    Comment.where(commentable_id: commentable_id, commentable_type: commentable_type).order(created_at: :desc)
  end

  private

  def render_json_object_result(result)
    if result
      render json: { status: 'success', message: t('.success') }
    else
      render json: {
        status: 'failure',
        errors: comment.errors
      }
    end
  end

  def comment_params
    params.require(:comment).permit(*PERMITTED_PARAMS) if params[:comment]
  end
end
