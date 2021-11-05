require "json"

module DBot
    class ResponseWrapper
        def initialize(http_response)
            @http = http_response
        end

        attr_reader :http

        def code
            @http.code
        end
    end

    class JsonResponse < ResponseWrapper
        def initialize(http_response)
            super(http_response)
            @json = parse_body(@http)
        end

        def empty?
            @json.nil? || @json.empty?
        end

        attr_reader :json

        private

        def parse_body(response)
            return {} if response.body.nil?

            begin
                JSON.parse(response.body)
            rescue error
                {}
            end
        end
    end
end