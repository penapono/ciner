class Api::V1::CommentsController < ApplicationController
  include ::BaseController

  PER_PAGE = 10

  PERMITTED_PARAMS = [
    :user_id, :commentable_type, :commentable_id, :content, :status,
    :origin, :spoiler, :featured, :commentable, :user
  ]

  expose(:comment) { resource }
  expose(:comments) { find_comments }

  # actions

  def index
    render partial: 'index', layout: false
  end

  def create
    render_json_result(comment.save)
  end

  def destroy
    render_json_result(comment.destroy)
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

  def find_comments
    Comment.all.order(created_at: :desc)
  end

  private

  def render_json_result(result)
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
    if params[:comment]
      params.require(:comment).permit(*PERMITTED_PARAMS)
    end
  end

end
