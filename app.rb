require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'nokogiri'
require 'uri'

get '/' do
  url = "http://m.comic.naver.com/webtoon/weekday.nhn"
  doc = get_doc(url)
  toons = doc.css('#pageList > li')
  @webtoons = Array.new
  toons.each do |toon|
    next if toon.css('div.lst > a').first.nil? or toon.css('.im_inbr > img').first.nil?
    t = {
      title: toon.css('.toon_name').text,
      link: toon.css('div.lst > a').first['href'],
      img_url: toon.css('.im_inbr > img').first['src']
    }
    @webtoons << t
  end
  erb :index
end

get '/search' do
  keyword = params[:q]
  url = "http://m.comic.naver.com/search/result.nhn?keyword="
  doc = get_doc(url + keyword)
  toons = doc.css('ul.toon_lst > li')
  @webtoons = Array.new

  toons.each do |toon|
    next if toon.css('div.lst > a').first.nil? or toon.css('.im_inbr > img').first.nil?
    t = {
      title: toon.css('.toon_name').text,
      link: toon.css('div.lst > a').first['href'],
      img_url: toon.css('.im_inbr > img').first['src']
    }
    @webtoons << t
  end
  erb :result
end

def get_doc(url)
  response = RestClient.get(URI.encode(url))
  Nokogiri::HTML(response)
end
