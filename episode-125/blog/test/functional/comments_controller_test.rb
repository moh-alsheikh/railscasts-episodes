require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    super
    @request.host = "#{Blog.first.subdomain}.localhost"
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to article_url(Comment.last.article_id)
  end
  
  def test_edit
    get :edit, :id => Comment.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Comment.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Comment.first
    assert_redirected_to article_url(Comment.first.article_id)
  end
  
  def test_destroy
    comment = Comment.first
    delete :destroy, :id => comment
    assert_redirected_to article_url(comment.article_id)
    assert !Comment.exists?(comment.id)
  end
end
