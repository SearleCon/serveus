module ApplicationHelper
  def title(title)
    content_for(:title, title)
  end

  def description(description)
    content_for(:description, description)
  end

  def keywords(keywords)
    content_for(:keywords, keywords)
  end

  def errors_for(model)
    if model && model.errors.any?
      content_tag(:div, class: 'error_explanation') do
        concat (content_tag(:div, "#{pluralize(model.errors.count, 'error')} prevented this record from being saved:", class: 'alert alert-error' ))
        concat ( content_tag(:ul) { model.errors.full_messages.map do |msg|
             content_tag(:li, msg)
          end.join().html_safe
          })
      end
    end
  end

  def first_time_user?
    current_user && current_user.sign_in_count == 1
  end

  def contact_information(interaction)
    if interaction.contact_person?
      interaction.contact_detail? ? "Contacted #{interaction.contact_person.titleize} via #{interaction.contact_detail}" :"Contacted #{interaction.contact_person.titleize}"
    elsif interaction.contact_detail?
      "Contacted #{interaction.contact_detail}"
    end
  end

  #Devise
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    devise_mapping.to
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


end
