# server.rb
require 'sinatra'
require 'net/http'
require 'json'

get '/' do
  @results = nil
  erb :search
end

post '/search' do
  content_type :json
  @search = params[:q]
  p "search for #{params}"
  JSON.parse(Net::HTTP.get(URI('http://api.indeed.com/ads/apisearch?' + URI.encode_www_form(
    publisher: ENV['INDEED_PUBLISHER_ID'],
    v: '2',
    format: 'json',
    q: @search,
    l: 'New York, NY',
    sort: 'date',
    radius: '10',
    st: 'employer',
    # // jt: '', // "fulltime", "parttime", "contract", "internship", "temporary"
    # // start: '',
    limit: 100,
    fromage: 7,
    # // highlight: '',
    filter: 0, #// remove duplicates
    latlong: 1,
    # // co: '',
    chnl: 'NYCDA,+NYC',
    userip: request.ip,
    useragent: request.user_agent
  )))).to_json
end