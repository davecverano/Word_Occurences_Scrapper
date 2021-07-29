require "minitest/autorun"
require './news.rb'
 
class TestNews < MiniTest::Test
 
  def setup
    @news = News.new("9/21/14","Article Sample","texttextext","https://examplewebsite.com")
  end
  
  def test_has_date
    assert_respond_to @news, :date
  end
  
  def test_has_title
    assert_respond_to @news, :title
  end
  
  def test_has_body
    assert_respond_to @news, :body
  end
  
  def test_has_link
    assert_respond_to @news, :link
  end
  
end
