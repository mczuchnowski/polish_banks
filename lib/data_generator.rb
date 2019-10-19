#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'

BANK_NAME_COL = 1
BRANCH_IDENTIFIER_COL = 4
BRANCH_NAME_COL = 5
DATA_DIR_NAME = 'data'
FILENAMES = ['plewibnra.txt', 'PlainDok.txt'].freeze

filename = FILENAMES.detect { |file| File.exist?(file) }

FileUtils.mkdir_p(DATA_DIR_NAME) unless File.directory?(DATA_DIR_NAME)

file = File.open(filename, 'r', encoding: 'CP852')

file.each_line do |row|
  row = row.encode(Encoding.find('UTF-8'), invalid: :replace, undef: :replace, replace: '').split("\t").map(&:strip)

  branch_identifier = row[BRANCH_IDENTIFIER_COL]
  bank_identifier = branch_identifier.slice(0, 4)
  branch_name = row[BRANCH_NAME_COL]

  data_file = "#{DATA_DIR_NAME}/#{bank_identifier}.yml"

  content = {
    branch_identifier.to_i => {
      'branch' => branch_name
    }
  }

  if File.exist?(data_file)
    yaml_string = File.read(data_file)
    data = YAML.safe_load(yaml_string)

    content = data.merge(content)
  else
    File.new(data_file, 'w+')

    bank_name = row[BANK_NAME_COL].strip
    content = { 'name' => bank_name }.merge(content)
  end

  File.open(data_file, 'r+') do |f|
    f.write(content.to_yaml(line_width: -1))
  end
end
