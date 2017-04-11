# frozen_string_literal: true

module FormHelper
  def checkbox_item(f, field)
    class_name = object_class_name(f.object)
    checked = checked_field?(f.object, field)
    checkbox_item_tag(f, field, class_name, checked)
  end

  private

  def checkbox_item_tag(f, field, class_name, checked)
    css_class = checked_class(checked)

    content_tag :span, data: { checkboxes: '' } do
      f.label field, data: { check_box: '' }, class: css_class do
        concat t("activerecord.attributes.#{class_name}.#{field}")
        concat f.check_box(field, class: 'checkbox', data: { check_item: '' })
      end
    end
  end

  def checked_field?(object, field)
    object.send(field)
  end

  def checked_class(checked = true)
    checked ? 'checked' : ''
  end

  def object_class_name(object)
    object.class.name.underscore
  end
end
