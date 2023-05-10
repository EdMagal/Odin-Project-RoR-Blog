class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id]) # find the article
    @comment = @article.comments.find(params[:id]) # find the comment
    @comment.destroy # destroy the comment
    redirect_to article_path(@article), status: :see_other # redirect to the article
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
