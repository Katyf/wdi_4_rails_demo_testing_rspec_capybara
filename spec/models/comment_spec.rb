require 'rails_helper'

RSpec.describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      article = Article.create!(title: "Hello World", body: "Ciao Hello Bonjour")

      expect(article.comments.create()).to be_a Comment
    end
 end
end
