module Service
  module Mailgun
    module Builders
      class URLBuilder
        def build
          AppConfig::ServiceSettings.mailgun_base_url
        end
      end
    end
  end
end