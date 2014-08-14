# StackOverflow to Yammer posting service
# Reagan Williams (reagan.williams@microsoft.com) Aug 2014

require 'faraday'
require 'json'
require 'sqlite3'

token_stack = "STACK_TOKEN"
token_yammer = "YAMMER_TOKEN"
groupid_yammer = ""

db_filename = "db.sqlite"


#response = Faraday.post do |req|
#    req.url "https://www.yammer.com/api/v1/shares"
#    req.headers["Authorization"] = "Bearer " + BearerToken
#    req.params['attached_objects'] = ["page:585285"]
#    req.params['shared_with_emails'] = [SharedWithEmails]
#    req.params['body'] = "WHO"
#end

#print response.body 

# conn = Faraday.new(:url => 'http://yammer.com') do |y|
#   y.use Faraday::Request::UrlEncoded  # encode request params as "www-form-urlencoded"
#   y.use Faraday::Response::Logger     # log request & response to STDOUT
#   y.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
# end

# response = conn.get '/nigiri/sake.json'     # GET http://sushi.com/nigiri/sake.json
# response.body

# conn.post '/nigiri', { :name => 'Maguro' }  # POST "name=maguro" to http://sushi.com/nigiri



# begin

#     db = SQLite3::Database.open db_filename
#     db.execute "INSERT INTO questions VALUES ('111', 'reagan', 'williams');"

# rescue SQLite3::Exception => e
#     puts "Exception occured"
#     puts e

# ensure
#     db.close if db
# end


