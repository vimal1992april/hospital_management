require 'paperclip/url_generator'

module Paperclip
  class UrlGenerator
    def escape(url)
      ERB::Util.url_encode(url.to_s)
    end
  end
end
