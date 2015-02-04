require 'rails_helper'

RSpec.describe CommentsController do

   let(:valid_attributes) {
    { body: "You won't believe what happens next..." }
  }

  let(:invalid_attributes) {
    { body: nil }
  }

  before(:all) do
    Article.destroy_all
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    @comment = @article.comments.create!(body:"cool article")
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index, article_id: @article.id
      expect(response.status).to eq 200
    end

    it 'renders the index template' do
      get :index, article_id: @article.id
      expect(response).to render_template('index')
    end

    it 'assigns @comments' do
      comments = Comment.all
      get :index, article_id: @article.id
      expect(assigns(:comments)).to eq comments
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new, article_id: @article.id
      expect(response.status).to eq 200
    end

    it 'renders the new template' do
      get :new, article_id: @article.id
      expect(response).to render_template('new')
    end

    it 'assigns @comment' do
      get :new, article_id: @article.id
      expect(assigns(:comment)).to be_a_new Comment
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'saves a new comment' do
        expect {
          post :create, article_id: @article.id, comment: valid_attributes
        }.to change(Comment, :count).by 1
      end

      it 'assigns @comment' do
        post :create, comment: valid_attributes, article_id: @article.id
        expect(assigns(:comment)).to be_an Comment
        expect(assigns(:comment)).to be_persisted
      end

      it 'redirects to the comments index' do
        post :create, comment: valid_attributes, article_id: @article.id
        expect(response).to redirect_to article_path(@comment.article_id)
      end
    end

    context 'with invalid attributes' do
      it 'assigns @comment, but does not save a new comment' do
        post :create, article_id: @article.id, comment: invalid_attributes
        expect(assigns(:comment)).to be_a_new Comment
      end

      it 're-renders the new template' do
        post :create, article_id: @article.id, comment: invalid_attributes
        expect(response).to render_template 'new'
      end
    end
  end

end
