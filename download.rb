#!/usr/bin/env ruby

require 'pry'
require 'open-uri'
require 'nokogiri'

url = 'http://nahlizenidokn.cuzk.cz/stahniadresnimistaruian.aspx'
doc = Nokogiri::HTML(open(url).read)

element = doc.css '#ctl00_bodyPlaceHolder_linkCR'
url = element.attr('href').value
file_name = element.inner_text

fail "Bad file name #{file_name}" if file_name.match(/\A[0-9A-Z_]+_csv.zip\z/).nil?


tgt = "db/#{file_name}"

puts File.exist?(tgt) ? "File #{tgt} allready exists" : system("wget",'-O',tgt,url)
system('unzip',tgt)