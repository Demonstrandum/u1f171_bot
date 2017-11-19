require 'telegram/bot'
Dir["#{File.dirname __FILE__}/u1f171_bot/*.rb"].each { |f| puts f; require f }


module U1F171
  VERSIONS = { :major => 0, :minor => 1, :tiny => 0 }

  def self.version *args
    VERSIONS.flatten.select.with_index { |val, i| i.odd? }.join '.'
  end
end

