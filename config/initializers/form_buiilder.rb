module ActionView
  module Helpers
    class FormBuilder
      alias orig_label label

      def label(method, content_or_options = nil, options = nil, &block)
        if content_or_options && content_or_options.class == Hash
          options = content_or_options
        else
          content = content_or_options
        end

        orig_label(method, content_str(content, method), options || {}, &block)
      end

      private

      def content_str(_content, method)
        required_mark = ''
        required_mark = ' *' if object &&
          validators_include?(object.class.validators_on(method).map(&:class))

        I18n.t('activerecord.attributes.' \
               "#{object.class.name.underscore}.#{method}") + required_mark
      end

      def validators_include?(validators)
        (validators.include? ActiveModel::Validations::PresenceValidator) ||
          (validators.include? ActiveRecord::Validations::PresenceValidator)
      end
    end
  end
end
