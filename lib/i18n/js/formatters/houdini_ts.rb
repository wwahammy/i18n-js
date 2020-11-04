require "i18n/js/formatters/base"
require "hash"

module I18n
  module JS
    module Formatters
			class HoudiniTs < Base
				def initialize(prefix: nil, suffix:nil)
					super(prefix: prefix, suffix: suffix)
				end

        def format(translations)
					contents = header
          translations.each do |locale, translations_for_locale|
            contents << line(locale, format_json(Hash.to_dotted_hash(translations_for_locale).map{|k, v| [k, HoudiniTs::sub_translation_value(v)]}.to_h))
          end
          contents << (@suffix || '')
        end

        protected

        def header
          text = @prefix || ''
					#text + %(#{@namespace}.translations || (#{@namespace}.translations = {});\n)
					text
        end

        def line(locale, translations)
          %(translations["#{locale}"] = #{translations};\n)
				end

				def self.sub_translation_value(value)
					if (value.is_a?(String))
						return value.gsub("%{", "${")
					end
				end
      end
    end
  end
end
