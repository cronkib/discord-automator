require "discordrb"
require_relative "./event_handler"

module DBot
    class DiscordBot
        def initialize(token)
            @token = token
            @event_handlers = []
            @bot = nil
        end

        def run
            @bot = Discordrb::Bot.new token: @token
            @bot.message do |event|
                trigger_event(event)
            end
            @bot.run
        end

        def event(handler)
            @event_handlers << handler if handler.is_a?(EventHandler)
        end

        def clear_handlers
            @event_handlers.clear
        end

        private

        def trigger_event(event)
            @event_handlers&.each do |handler|
                handler&.handle_event(event)
            end
        end
    end
end