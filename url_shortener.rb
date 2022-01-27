require 'date'

class UrlShortener
    attr_accessor :urls

    def initialize
        @urls = {}
    end

    def generate_stub
        range = [*'0'..'9',*'A'..'Z',*'a'..'z']
        stub = Array.new(6){ range.sample }.join
    end

    def is_unique(stub)
        !@urls.include?(stub)
    end

    def shorten(url)
        stub = nil

        loop  do
            stub = generate_stub
            break if is_unique(stub) && stub != nil 
        end 

        @urls[stub] = ShortUrl.new(url)

        stub
    end

    def get_url(stub)
        @urls[stub]
    end
end

class ShortUrl
    attr_accessor :url
    
    def initialize(url)
        @url = url
        @expiry_date = Date.today.next_day(30)
    end

    def expiry
        @expiry_date
    end
end