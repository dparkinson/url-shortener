require_relative '../url_shortener'
require 'date'

describe UrlShortener do
  context 'when generating a new url' do
    before do
        @shortener = UrlShortener.new
    end

    it 'should create a 6 character string' do
    #   shortener = UrlShortener.new
      expect(@shortener.generate_stub.length).to eql(6)
    end

    it 'should store the generating stub in a hash' do
      stub = @shortener.shorten('')

      expect(@shortener.urls).to include(stub)
    end

    it 'should store a url along side the stub' do
      stub = @shortener.shorten('http://www.example.com/')

      expect(@shortener.urls[stub].url).to eql('http://www.example.com/')
    end

    it 'should ensure that the stub is unique' do
      @shortener.urls['test12'] = ''

      expect(@shortener.is_unique('test12')).to be_falsey
    end
    
  end

  context 'when requesting a url' do
    before do
        @shortener = UrlShortener.new    
    end

    it 'should return the original url from a stub' do
        @shortener.urls['8WjsAU'] = 'http://www.example.com/'

        expect(@shortener.get_url('8WjsAU')).to eql('http://www.example.com/')
    end

    it 'should not find any url for an invalid stub' do
        expect(@shortener.get_url('test12')).to be_nil
    end
  end

  context 'urls should have an expiry date' do
    before do
        @shortener = UrlShortener.new
    end

    it 'should expire in 30 days' do
        stub = @shortener.shorten('http://www.example.com')
        date = Date.today.next_day(30)

        expect(@shortener.get_url(stub).expiry.strftime("%Y-%m-%d")).to eql(date.strftime("%Y-%m-%d"))
    end
  end
end

describe ShortUrl do
    context 'with a default short url' do
        it 'should expire in 30 days' do
            url = ShortUrl.new('http://www.example.com/')
            expiry_date = Date.today.next_day(30)

            expect(url.expiry).to eql(expiry_date)
        end
    end
end