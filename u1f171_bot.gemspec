require_relative 'lib/u1f171_bot'

Gem::Specification.new do |s|
  s.name        = 'u1f171_bot'
  s.version     = U1F171::version
  s.required_ruby_version = '>= 2.0.0'
  s.executables << 'u1f171-bot'
  s.date        = Time.now.to_s.split(/\s/)[0]
  s.summary     = "A Telegram \u{1f171}ot"
  s.description = "A simple bot that turns letters in to \u{1f171}s."
  s.authors     = ["Demonstrandum"]
  s.email       = 'knutsen@jetspace.co'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path= 'lib'
  s.add_dependency 'telegram-bot-ruby', '~> 0.8', '>=0.8.5'
  s.homepage    = 'https://github.com/Demonstrandum/u1f171_bot'
  s.license     = 'GPL-3.0'
end
