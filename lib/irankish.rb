

%w(validatable).each do |dependency|
  require dependency
end

module Irankish
 
  class << self
    attr_accessor :configuration
  end
  
  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :merchantId, :revertURL,:getTokenWSDL,:verifyWSDL,:sha1Key
   
    def initialize
  
    end

  end


end


%w(version validate_token_response get_token).each do |identify|
  require "irankish/#{identify}"
end
