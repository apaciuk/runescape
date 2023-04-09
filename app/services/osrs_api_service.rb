class OsrsApiService < ApplicationService
    BASE_URL = 'https://secure.runescape.com'
    
    def self.player_data(username) 
        response = connection.get("/m=hiscore_oldschool/index_lite.ws?player=#{username}")

        if response.success?
            # Process the data
            process_data(response.body, username)
        else
            # Handle errors
            response.body
        end
    end 

    def self.connection 
        Faraday.new(url: BASE_URL) do |conn|
            conn.adapter Faraday.default_adapter 
            conn.request :url_encoded
            conn.response :logger
            conn.response :json, content_type: /\bjson$/
        end
    end 

    def self.process_data(data, username)
        data = data.split("\n")
        data.map do |line|
            line = line.split(',')
            {
                username: username,
                skill: line[0],
                rank: line[1],
                level: line[2],
                experience: line[3]
            }
        end
    end 
end 


