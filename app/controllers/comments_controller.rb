class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment: params[:comment], event_id: params[:event_id], user_id: session[:user_id])
    if comment.save
      # do nothing
    else
      flash[:error] = {:comment => comment.errors[:comment]}
    end
    redirect_to '/events/' + params[:event_id]
  end
end
