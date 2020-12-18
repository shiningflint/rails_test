class TweetsController < ApplicationController

  def create
    tweet = Tweet.new(tweet_params[:title], tweet_params[:photo_url], session[:tweet_token])
    tweet.create

    if tweet.errors.any?
      flash[:error] = tweet.errors
    else
      flash[:notice] = ['ツイートしました！']
    end

    redirect_to user_path(current_user.id)
  end

  private

  def tweet_params
    params.permit(:title, :photo_url)
  end

end
