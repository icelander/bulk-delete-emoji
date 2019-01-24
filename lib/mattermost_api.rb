require 'httparty'

class MattermostApi
	include HTTParty

	format :json
	# debug_output $stdout
	
	def initialize(mattermost_url, auth_token)
		@base_uri = mattermost_url + 'api/v4/'
		
		@options = {
			headers: {
				'Content-Type' => 'application/json',
				'User-Agent' => 'Custom-Emoji-Removal'
			},
			# TODO Make this more secure
			verify: false
		}
		
		token = auth_token
		
		@options[:headers]['Authorization'] = "Bearer #{token}"
		@options[:body] = nil

	end

	def find_custom_emoji(emoji_name)
		get_url("emoji/name/#{emoji_name}")
	end

	def delete_emoji(emoji_name)
		emoji = find_custom_emoji(emoji_name)

		if delete("emoji/#{emoji['id']}")
			return "Deleted #{emoji_name}"
		else
			return "ERROR!"
		end
	end

	private

	def post_data(payload, request_url)
		options = @options
		options[:body] = payload.to_json

		self.class.post("#{@base_uri}#{request_url}", options)
	end

	def get_url(url)
		JSON.parse(self.class.get("#{@base_uri}#{url}", @options).to_s)
	end

	def delete(request_url)
		response = JSON.parse(self.class.delete("#{@base_uri}#{request_url}", @options).to_s)
		if response['status'].nil? || response['status'] != 'OK'
			return false
		else
			return true
		end
	end
end