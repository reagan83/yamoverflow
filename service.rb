# StackOverflow to Yammer posting service
# Reagan Williams (reagan.williams@microsoft.com) Aug 2014

require 'sqlite3'
require 'json'
require 'faraday'
require 'yaml'

# Configs
$config = YAML.load_file("yamoverflow.yml")

# Setup existing questions dataset
$existing_question_ids = Array.new

# Search StackOverflow
def search_stackoverflow(endpoint)
    response = Faraday.get do |req|
       req.url endpoint
    end

    questions = JSON.parse(response.body)

    h = Hash.new
    questions['items'].each do |question|
        # write record to database & yammer
        unless $existing_question_ids.include?(question['question_id'])
            post_to_yammer($config['yammer_group_id'], question['link'], question['title'])
            save_to_db(question['question_id'], question['link'], question['title'])

        end

        break
    end
end

# Post Message to Yammer
def post_to_yammer(group_id, link, title)
    conn = Faraday.new('https://www.yammer.com/') do |c|
      c.use Faraday::Adapter::NetHttp
      c.headers["Authorization"] = "Bearer " + $config['yammer_token']
      c.params["group_id"] = group_id
      c.params["og_url"] = link
      c.params["og_fetch"] = true
      c.params["body"] = title
    end

    #response = conn.post('/api/v1/messages.json')
    print link + "\n" + title + "\n\n"
end

# Save Question Metadata to DB
def save_to_db(id, link, title)
    begin
        db = SQLite3::Database.open $config['db_filename']

        # yes i know this is vuln to titles with sql injections in them :)
        db.execute "INSERT INTO questions VALUES (" + id.to_s + ", '" + link + "', '" + title + "');"

    rescue SQLite3::Exception => e
        puts "Exception occured"
        puts e

    ensure
        db.close if db
    end
end

def pull_existing_questions()
    begin
        db = SQLite3::Database.open $config['db_filename']
        stmt = db.prepare "SELECT question_id FROM questions"
        rs = stmt.execute

        # I can call rs.to_a here but the records are returned as 1-d arrays in an array
        rs.each do |row|
            $existing_question_ids.push row[0]
        end 

    rescue SQLite3::Exception => e
        puts "Exception occured"
        puts e

    ensure
        stmt.close if stmt
        db.close if db
    end

end


pull_existing_questions()

search_stackoverflow($config['so_search_api'] + $config['so_search_tags'])


