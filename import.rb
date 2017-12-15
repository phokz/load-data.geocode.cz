#!/usr/bin/env ruby

require 'csv'

def import_file(file)
  insert = 'insert into addresses(id,city_id,city_part_id,street_id,postcode_id,number,evidence,orient,letter) values '
  n = 0
  buf = []
  File.open('sql', 'w') do |fo|
    CSV.foreach(file, col_sep: ';') do |row|
      id = row.shift
      city = row.shift
      city_part = row.shift
      street = row.shift
      type = row.shift
      number = row.shift
      orient = row.shift
      letter = row.shift
      postcode = row.shift

      orient = 'NULL' if orient.nil?
      letter = letter.nil? ? 'NULL' : "'#{letter}'"
      city_id = @cities[city]
      city_part_id = city_part.nil? ? 'NULL' : @city_parts[city_part]
      street_id = street.nil? ? 'NULL' : @streets[street]
      postcode_id = @postcodes[postcode]
      evidence = type == 'č.ev.' ? 1 : 0

      buf << "(#{id}, #{city_id}, #{city_part_id}, #{street_id}, #{postcode_id}, #{number}, #{evidence}, #{orient}, #{letter})"
      n += 1
      if buf.size >= 10_000
        fo.puts "#{insert} #{buf.join(', ')};"
        buf = []
        print "\r#{n}    "
      end
    end
    fo.puts "#{insert} #{buf.join(', ')};"
  end
end

def load_enum(i)
  sql = i == :postcodes ? "insert into #{i}(id, number)" : "insert into #{i}(id, name)"
  v = []
  h = {}
  File.open("CSV/#{i}").read.split("\n").each_with_index do |item, index|
    h[item] = index + 1
    v << "(#{index + 1}, '#{item}')"
  end
  @f.puts "#{sql} values #{v.join(', ')};"
  instance_variable_set('@' + i.to_s, h)
end

File.open('sql1', 'w') do |f|
  @f = f
  load_enum :cities
  load_enum :city_parts
  load_enum :streets
  load_enum :postcodes
end

import_file('CSV/addresses')
