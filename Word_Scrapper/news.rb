# A single news article scraped from the news index.
#   date  - date the article was written
#   title - title of the article
#   body  - preview text shown on the index page
#   link  - path to the full article (relative to the site root)
class News
  attr_reader :date, :title, :body, :link

  def initialize(date, title, body, link)
    @date = date
    @title = title
    @body = body
    @link = link
  end
end
