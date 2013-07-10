class DateTimePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'datetime') do
      @builder.text_field(attribute_name, input_html_options) +
      template.content_tag(:span, class: "add-on") do
        template.content_tag(:i, nil, data: {date_icon: 'icon-calendar', data_time_icon: 'icon-time'})
      end
    end
  end
end