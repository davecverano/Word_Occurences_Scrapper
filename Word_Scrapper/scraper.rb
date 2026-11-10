require 'mechanize'
require 'nokogiri'
require_relative 'news'

BASE_URL = 'https://cse.osu.edu'.freeze
NEWS_URL = "#{BASE_URL}/news".freeze
TOP_N = 30

# Characters treated as word separators (whitespace, punctuation, nbsp, smart quotes, em dash).
WORD_SEPARATORS = /[\s,.":;$!?\/() ”“—]/

# Counts the total number of news pages using the per-year article counts on the first page.
def page_count(agent)
  page = Nokogiri::HTML(agent.get(NEWS_URL).body)
  total_articles = page.css('span.news-date-block-year-subcount').children.children.sum { |n| n.text.to_i }
  per_page = page.css('div.region-large').count
  return 0 if per_page.zero?

  (total_articles.to_f / per_page).ceil
end

# Returns the News articles listed on one page of the news index.
def articles_on_page(agent, index)
  page = Nokogiri::HTML(agent.get("#{NEWS_URL}?page=#{index}").body)
  page.css('div.region-large').map do |elt|
    News.new(
      elt.css('span.content-type-news').text,
      elt.css('h2.content-type-news').text,
      elt.css('div.content-type-news').text,
      elt.css('a')[0].attributes['href'].value
    )
  end
end

# Fetches an article and returns its body text split into lowercase words.
def article_words(agent, news)
  page = Nokogiri::HTML(agent.get(BASE_URL + news.link).body)
  page.css('div.content-body.content-type-news').text.downcase.split(WORD_SEPARATORS)
end

# Lets the user look up word frequencies until they type QUIT.
def display_results(word_counts)
  loop do
    puts "\nEnter a word to see its frequency. Enter QUIT to quit."
    key = gets.chomp
    break if key == 'QUIT'

    count = word_counts[key.downcase]
    puts count.zero? ? "No matches for \"#{key}\"." : "#{count} matches for \"#{key}\"."
  end
end

def main
  agent = Mechanize.new
  word_counts = Hash.new(0)

  puts 'Fetching website data...'
  pages = page_count(agent)
  pages.times do |index|
    articles_on_page(agent, index).each do |news|
      article_words(agent, news).each { |word| word_counts[word] += 1 }
    end
    puts "Pages parsed: #{index + 1} of #{pages}..."
  end

  word_counts.delete('')

  top = word_counts.sort_by { |_word, count| -count }.first(TOP_N)
  puts "Here are the top #{top.length} most frequently used words in all the articles on the website."
  top.each_with_index { |(word, count), i| puts "#{i + 1}: #{word} - #{count}." }

  display_results(word_counts)
end

main if __FILE__ == $PROGRAM_NAME
