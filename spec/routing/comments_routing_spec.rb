 require 'rails_helper'

RSpec.describe 'routes for comments' do
   @article = Article.create!(title: "Hello World", body: "Ciao Hello Bonjour")
   @comment = @article.comments.create!(body: "cool article")
  it 'routes GET articles/article_id/comments to the comments controller' do
    expect(get("articles/1/comments")).to route_to(
      controller: 'comments',
      action: 'index',
      article_id: '1'
      )
  end

  it 'routes GET articles/article_id/comments/comment_id to the comments controller' do
    expect(get("articles/1/comments/1")).to route_to(
      controller: 'comments',
      action: 'show',
      article_id: '1'
      )
end


end
