require 'mechanize'
require 'nokogiri'
require './news.rb'

### METHODS ###

# Description:
    # This method takes in the hash and based on user input outputs the correct result
# Ensures:
    # allWords is hash with keys being words and value being their frequencies

def displayResults(allWords)

	# Initialize user input variable
	key = ""
	
    # User can enter a word and check its frequency, until they input QUIT
    until key == "QUIT" 	
		puts "\nEnter a word to see it's frequency. Enter QUIT to quit.\n"
		key = gets.chomp
		
		if key == "QUIT"
			# Do nothing
		elsif allWords[key] == 0
			puts "No matches for \"#{key}\".\n" 
		else
			puts "#{allWords[key]} matches for \"#{key}\"."
		end
    end
end

### END OF METHODS ###

### MAIN BODY ###

def main 

	# Initialize Mechanize class and variables
    agent = Mechanize.new
    words_arr = [] 
    index = 0
    total = []
    
    # HTTP GET request to get raw html
    unparsed_page = agent.get "https://cse.osu.edu/news"
    
    # Allow Nokogiri to parse the page
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    
	# Allow the indexing to work even if page numbers increase or decrease
    number = parsed_page.css('span.news-date-block-year-subcount').children.children  # each year number
    news_list = parsed_page.css('div.region-large') # data for each news article on the page
    per_page = news_list.count    # number of articles per page
    
    # Add each number of articles into an array
    number.each do |i|
        total << i.text.to_i
    end
    
    # Sum the total number of articles
    sum = total.reduce do |acm, elt|   
        acm += elt
    end
    
    #Calculate the number of pages of articles using total articles and amount per page
    pages = sum / per_page      
    
    # Reassure user that program did not freeze
    puts "Fetching website data..."
    
    # Run scraper for each page of news articles
    while index < pages
    	
    	# GET specific page of news articles and parse the html
    	unparsed_page = agent.get "https://cse.osu.edu/news?page=#{index}"
    	parsed_page = Nokogiri::HTML(unparsed_page.body)
    	news_list = parsed_page.css('div.region-large') #data for 10 news per page
    	
    	# Initialize news array
    	news_arr = []
	
		# Loop through the webpage data and get info for each news article
		news_list.each do |elt|
			date = elt.css('span.content-type-news').text           #date of the news
			title = elt.css('h2.content-type-news').text		#title of the news
			body = elt.css('div.content-type-news').text		#preview of the news
			link = elt.css('a')[0].attributes["href"].value        #link the the news  
			
			# Create and initialize News object
			temp = News.new(date,title,body,link)	
			
			# Add News object to array
			news_arr << temp
		end
    
    	# Loop through whole news object array, and add words in each article to an array
		news_arr.each do |elt|
			
			# GET and parse specific article
			url = "https://cse.osu.edu" + elt.link		
			tempPage = agent.get(url)
			tempParsedPage = Nokogiri::HTML(tempPage.body)
			
			# Parse large string into all of its separate words, downcased
			body = tempParsedPage.css('div.content-body.content-type-news').text.downcase.split(/[\s,.":;\$\!\?\/\(\)\u00A0\u201d\u201c\u2014]/)
			
			# Add article body words to the large words array
			words_arr << body
		end
		
		# Increment index
		index += 1
		# Update user on progress
		puts "Pages parsed: #{index}..."
    end
    
    # Create hashmap to map words to their frequency
    allWords = Hash.new 0
    words_arr.each do |elt|
    	elt.each{|v| allWords[v] += 1}
    end
    
    # Delete empty whitespace words that slip through tokenizer
    allWords.delete ""
    
    # Sort all words in the order of decreasing frequency		
    freqArray = allWords.sort_by{|key,value| value}
    
    # Display the top 30 most frequently used words
    puts "Here are the top 30 words most frequently used in all the articles on the website. \n"
    
    # Loop through freqArray and print the first 30 words with their frequencies
    i = 1
    while i < 31		#output the top 30 most frequent words
    	puts "#{i}: #{freqArray[freqArray.length-i][0]} - #{freqArray[freqArray.length-i][1]}."
    	i += 1
    end
    
    # Call displayResults
    displayResults(allWords)
    
end

main
