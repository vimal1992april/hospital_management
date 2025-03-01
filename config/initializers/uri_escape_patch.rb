require 'uri'
require 'cgi'

module URI
  class << self
    def escape(url)
      return '' if url.nil?
      url.to_s.gsub(/([^a-zA-Z0-9_.-]+)/) { |m| sprintf("%%%02X", m.ord) }
    end

    def unescape(url)
      CGI.unescape(url.to_s)
    end
  end
end
