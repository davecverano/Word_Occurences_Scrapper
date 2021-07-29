Project: Website Scraper

Team members: Justin Raiff, Dave Verano, Hanxiang Jang, Mitchell Bihn
All group members participated in writing, formatting, and testing code for each file.

Classes used:
- News: The News class holds data for each News object -- the title, link, body, and date of each article
- Scraper: This is where the main operations of the program are held
- NewsTest: This is used to test the creation of a news object. 

Few classes were needed at all because of Ruby's already-rich library of strings, hashes, and arrays. Adding much more modularity to the code would break up the flow of the methods and ultimately make the program less readable and followable. 

Welcome to our website scraper project!

Our goal for this program was to figure out how often what words were used in OSU CSE news articles. Subsequently, we could compare this to the most used words in the English language in general, and see how the results square up. 

For this program to run, the gems Mechanize and Nokogiri must be installed. Our experience developing this program has led us to believe that the best way to set this up is to make sure that Nokogiri is uninstalled, and when mechanize is installed it will also install a suitable version of Nokogiri automatically. This may vary system to system. 
This project uses HTTP requests to get data from a public Ohio State website -- the OSU CSE news site. Link: https://cse.osu.edu/news

The program sends GET requests to each page of the site, as well as each article on each page, and gathers a list of all the words and names used in every single article.
Note: When running this program, especially for the first time, expect a noticeable load time before output is printed. There are no delays in sending the GET requests, but to gather every word from every article and to store them can take a few seconds. 
Each word is then put in a hashmap, mapped to the amount of times it was used throughout the articles. The top 30 most frequently used words are displayed, as well as a prompt to check the frequency of any word. 

To check the frequency of any word, type the word when prompted by the program, and hit Enter. To end the program, type QUIT as the prompt states, and hit Enter. 

We found the top 6 words in these articles to be consistent with those from the English language in general, which is not all that surprising. However, we didn't run into nearly as many "you"s, as article writing is often a third person objective. 

To run the program, simply type "ruby scraper.rb" into the terminal. Also to run the test file, type "testNews.rb" into the terminal. 
