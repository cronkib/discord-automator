require "net/http"
require "json"
require_relative "../model/http_models"

module DBot
    class HTTPClient
        @@application_json = "application/json"

        def send_json(request, data)
            request["Content-Type"] = @@application_json
            request.body = JSON.generate(data)
            JsonResponse.new(send_request(request).http)
        end

        def send_request(request)
            uri = request.uri
            Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
                ResponseWrapper.new(http.request(request))
            end
        end
    end
end