require 'rails_helper'

RSpec.feature 'Managing Comments' do
  scenario 'List all comments for article' do
    article = Article.create!(title: "Hello World", body: "Ciao Hello Bonjour")

    article.comments.create!(body: 'cool article')
    article.comments.create!(body: 'cool article')
    article.comments.create!(body: 'cool article')

    visit ("/articles/#{article.id}/comments")

    expect(page).to have_content 'Comments'
    expect(page).to have_selector 'p', count: 3
  end

 scenario 'Create a new comment' do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")

    visit "/articles/#{@article.id}/comments/new"

    fill_in 'Body', with: "cool article"
    click_on 'Create Comment'

    expect(page).to have_content(/success/i)
  end

end

