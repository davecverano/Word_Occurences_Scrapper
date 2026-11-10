# Word Occurrences Scraper

A Ruby command-line tool that crawls every article on the [OSU Computer Science & Engineering news page](https://cse.osu.edu/news), counts how often each word appears, prints the 30 most common words and lets you look up the count for any word.

Try it on [Replit](https://replit.com/@DaveVerano/WordOccurencesScrapper).

![Demo](https://user-images.githubusercontent.com/49330823/180515438-59f326c0-5409-4ccc-87be-7ab244c34028.JPG)

## How it works

1. Reads the yearly article counts on the news index to work out how many pages there are.
2. Visits each index page and collects the articles (date, title, preview, link) as `News` objects.
3. Downloads each article, lowercases the body text and splits it into words.
4. Tallies the words, prints the top 30, then answers lookups until you type `QUIT`.

I built this to learn Ruby, using [Mechanize](https://github.com/sparklemotion/mechanize) for HTTP and [Nokogiri](https://nokogiri.org/) for HTML parsing.

> The scraper depends on the page structure of cse.osu.edu at the time it was written. If the site's HTML has changed, the CSS selectors in `scraper.rb` will need updating.

## Setup

Requires Ruby 2.7+ and Bundler.

```bash
git clone https://github.com/davecverano/Word_Occurences_Scrapper.git
cd Word_Occurences_Scrapper
bundle install
```

## Usage

```bash
cd Word_Scrapper
ruby scraper.rb
```

## Tests

```bash
cd Word_Scrapper
ruby testNews.rb
```

## Project layout

```
Word_Scrapper/
  scraper.rb    crawler, word counter and interactive lookup
  news.rb       News model (date, title, body, link)
  testNews.rb   Minitest tests for the News model
```
