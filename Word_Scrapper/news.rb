class News

    #getter for instance variables
    attr_reader :date, :title, :body, :link

    #instance variables: @date, @title, @body, @link
    #@date = date article was written
    #@title = title of the article
    #@body = body text of the article
    #@link = url to the article
      
    def initialize(date, title, body, link)
        @date = date
        @title = title
        @body = body 
        @link = link
    end 
    
    
end 
