# Remove Custom Emoji Script

This script

## Requirements

This script requires the [HTTParty](https://github.com/jnunemaker/httparty) gem to be installed. You can install it manually with:

```
gem install httparty
```

or if you have [Bundler](https://bundler.io/) run this:

```
bundle install
```

You will also need a Mattermost personal access token with administrative privileges. [Instructions for this are here.](https://docs.mattermost.com/developer/personal-access-tokens.html).

## Usage

1. Add the names for the emoji you want to remove to `emoji_list.txt`
2. Run `cp sample.conf.yaml conf.yaml` and edit the `url` and `auth_token` to match your environment
3. Run `./emoji_remove.rb` to verify the emoji that will be removed
4. Run `./emoji_remove.rb -f` to delete the emoji