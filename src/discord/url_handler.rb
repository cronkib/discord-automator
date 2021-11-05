require_relative "./event_handler"

module DBot
    class UrlHandler < EventHandler
        def handle_event(event)
            urls = URI.extract(event.message.content)

            unless urls.empty?
                puts "Found URL: #{urls.nil? ? 0 : urls.count}"
                handle_urls(event, urls)
            end
        end

        def handle_urls(event, urls) end
    end
end