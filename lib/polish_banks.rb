# frozen_string_literal: true

require 'pry'
require 'yaml'
require 'errors/bank_not_found'
require 'errors/unsupported_country'

class PolishBank
  attr_reader :name, :branch

  def initialize(iban)
    @iban = iban
    check_country
    data = YAML.load_file(File.join(File.dirname(__FILE__), 'data', "#{bank_identifier}.yml"))
    @name = data['name']
    @branch = data.dig(full_identifier, 'branch') || ''
  rescue Errno::ENOENT
    raise BankNotFound, "Polish bank not found for #{iban}"
  end

  private

  attr_reader :iban

  def account_number
    iban.to_s.tr('^0-9', '')
  end

  def bank_identifier
    account_number[2..5].to_i
  end

  def country_code
    iban.to_s[0..1]
  end

  def check_country
    return if integer?(country_code)

    raise UnsupportedCountry, "Iban #{iban} is not Polish" if country_code.casecmp('PL') != 0
  end

  def full_identifier
    account_number[2..9].to_i
  end

  def integer?(string)
    Integer(string)
  rescue ArgumentError
    false
  end
end
