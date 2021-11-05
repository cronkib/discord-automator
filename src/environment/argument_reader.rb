require "optparse"

module DBot
    Arguments = Struct.new(:config)

    class ArgumentReader
        def initialize
            @banner = "Usage: dbot.rb [options]"
        end

        def read_arguments
            opt_list = []
            OptionParser.new do |opts|
                opts.banner = @banner

                opts.on("-c", "--config CONFIG", "Specify CONFIG path to configuration") do |config|
                    opt_list << config
                end
            end.parse!

            Arguments.new(*opt_list)
        end
    end
end
