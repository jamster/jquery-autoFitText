#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'nokogiri'
require 'yajl/json_gem'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.imdb.com/title/tt0093779/'))

def get_bio(char)
  link = "http://www.imdb.com#{char}bio"
  ## Throws error due to swiki id names having .
  # Nokogiri::HTML(open(link)).css("div#swiki.2.3.1").content
  doc = open(link).read
  doc =  doc.gsub(/swiki\.2\.3\.1/, "iamthebio" )
  doc = Nokogiri::HTML(doc)
  doc.css("div#iamthebio").first.content
end

characters = doc.css("td.character div a").map do |link|
  {
    :name =>  link.content(),
    :pic => (link.parent().parent().parent().css("noscript img").attr("src") rescue nil),
    :actor => (link.parent().parent().parent().css("img").attr("alt") rescue nil),
    :bio => get_bio(link.attr("href"))
  }
end

output = {:characters => characters}.to_json
puts output
