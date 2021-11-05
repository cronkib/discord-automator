require "json"
require_relative "./http_models"

module DBot
    class GoogleURLStatusResponse < JsonResponse
        def match?
            return false if code != "200" || empty?

            match_list = @json["matches"]

            !match_list.nil? && match_list.is_a?(Array) && !match_list.empty?
        end
    end
end