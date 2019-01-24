#!/usr/bin/ruby

require Dir.pwd + '/lib/mattermost_api.rb'

$config = YAML.load(
	File.open('conf.yaml').read
)

mm_config = $config['mattermost_api']

mm = MattermostApi.new(mm_config['url'],
					   mm_config['auth_token'])

delete_emoji = false

if ARGV[0] == '-f'
	delete_emoji = true	
end

emoji = File.readlines('emoji_list.txt')

emoji.each do |e|
	emoji = mm.find_custom_emoji(e.strip)

	if emoji['status_code'].nil?
		puts "#{emoji['name']} found"

		if delete_emoji
			puts "DELETING #{emoji['name']}"
			if mm.delete_emoji(emoji['name'])
				puts "Deleted #{emoji['name']}"
			else
				puts "Error deleting #{emoji['name']}"
			end
		end
	else
		puts "#{e.strip} NOT FOUND"
	end
end