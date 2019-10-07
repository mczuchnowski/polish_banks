# PolishBanks - A Polish bank lookup Ruby gem.

Polish bank name and branch can be read from the IBAN or accont number.

`PLkk BBBB BBBB MMMM MMMM MMMM MMMM`

`PL` is the country code, `kk` are check digits. The `BBBB BBBB` is the bank and branch identifier needed to detect the bank.

Polish National Bank regularly publishes a single text file containing up-to-date information about all the Polish banks and their branches [here](https://ewib.nbp.pl/faces/PlainDok?dokNazwa=plewibnra.txt). The file uses CP852 encoding.

This gem makes it easier to identify banks and their branches based on the account number or IBAN.

## Installation

Add to your Gemfile:

    gem 'polish_banks'

And then execute:

    $ bundle install

Or install on your own to test it in irb:

    $ gem install polish_banks

## How to use it

You can use either IBAN or just account number - as string or as integer. If you don't provide the whole account number, the gem will try to determine at least the bank name. Non-Polish ibans will raise a `UnsupportedCountry` exception.

    require 'credit_card_bins'

    iban = "PL9912406999"
    bank = PolishBank.new(iban)

    bank.name #"Bank Polska Kasa Opieki Spółka Akcyjna"
    bank.branch #"Oddział w Tychach ul. Wyszyńskiego 27"

If bank is not found, the gem will raise a `BankNotFound` exception.

## Contributing

NOTE: To properly update bank lists, remove the /lib/data folder and run the data_generator.

1. Fork
2. Create a feature branch
3. Commit changes
4. Push to your branch
5. Create a new Pull Request based on your branch
