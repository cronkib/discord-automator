require_relative "./url_handler"

module DBot
    class SafeUrlHandler < UrlHandler
        def initialize(safeurl_service)
            @service = safeurl_service
            @image = "https://media2.giphy.com/media/njYrp176NQsHS/giphy.gif?cid=ecf05e47hxov7z1m19jiufrbtzdowks5jifktudjhcrmzgcd&rid=giphy.gif&ct=g"
        end

        def handle_urls(event, urls)
            response = @service.check_status(urls)
            response.match? ? bad_url(event, urls) : good_url(event, urls)
        end

        def bad_url(event, _urls)
            response = "**Notice**: Recent message by <@#{event.user.id}> contained a potentially unsafe URL.\n" \
                       "*Message yeeted and deleted.*"

            event.message.delete
            event.respond "#{response}\n#{@image}"
        end

        def good_url(_event, _urls)
            puts "good url"
        end
    end
end