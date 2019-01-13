require 'fileutils'
require 'yaml'

BANK_NAME_COL = 1
BRANCH_IDENTIFIER_COL = 4
BRANCH_NAME_COL = 5
DATA_DIR_NAME = 'data'.freeze
FILE_NAME = 'plewibnra.txt'.freeze

FileUtils.mkdir_p(DATA_DIR_NAME) unless File.directory?(DATA_DIR_NAME)

file = File.open(FILE_NAME, 'r', encoding: 'CP852')

file.each_line do |row|
  row = row.encode('UTF-8').split("\t").map(&:strip)

  branch_identifier = row[BRANCH_IDENTIFIER_COL]
  bank_identifier = branch_identifier.slice(0, 4)
  branch_name = row[BRANCH_NAME_COL]

  file_name = "#{DATA_DIR_NAME}/#{bank_identifier}.yml"

  content = {
    branch_identifier.to_i => {
      'branch' => branch_name
    }
  }

  if File.exist?(file_name)
    yaml_string = File.read(file_name)
    data = YAML.safe_load(yaml_string)

    content = data.merge(content)
  else
    File.new(file_name, 'w+')

    bank_name = row[BANK_NAME_COL].strip
    content = { 'name' => bank_name }.merge(content)
  end

  File.open(file_name, 'r+') do |f|
    f.write(content.to_yaml(line_width: -1))
  end
end
