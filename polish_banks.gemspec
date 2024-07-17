Gem::Specification.new do |s|
  s.name        = 'polish_banks'
  s.version     = '1.2.0'
  s.date        = '2021-07-04'
  s.summary     = 'Polish bank detector'
  s.description = 'Get information about a Polish bank based on IBAN or account number.'
  s.authors     = ['Maciej Czuchnowski']
  s.email       = 'maciej.czuchnowski@gmail.com'
  s.files       = `git ls-files -z`.split("\x0")
  s.homepage    = 'https://github.com/mczuchnowski/polish_banks'
  s.license     = 'MIT'
  s.add_development_dependency 'rspec', '~> 3.13'
  s.add_development_dependency 'simplecov'
end
