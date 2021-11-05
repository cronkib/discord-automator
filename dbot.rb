require "json"
require "uri"
require_relative "./src/environment/argument_reader"
require_relative "./src/config/config_loader"
require_relative "./src/client/google_client"
require_relative "./src/service/safeurl/google_safeurl_service"
require_relative "./src/discord/discord_bot"
require_relative "./src/discord/safeurl_handler"

class DBotRunner
    include DBot

    def run
        arguments = ArgumentReader.new.read_arguments
        config = ConfigLoader.load(arguments.config)

        safe_browsing_client = GoogleSafeBrowsingClient.new(config.google_key)
        safe_browser_service = GoogleSafeUrlService.new(safe_browsing_client)

        bot = DiscordBot.new(config.discord_bot_key)
        bot.event SafeUrlHandler.new(safe_browser_service)
        bot.run
    end
end

DBotRunner.new.run