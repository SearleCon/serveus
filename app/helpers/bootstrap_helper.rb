module BootstrapHelper
  def glyph(*names)
    content_tag :i, nil, class: names.map{|name| "icon-#{name.to_s.gsub('_','-')}" }
  end

  def nav_list
    haml_tag :ul, class: 'nav nav-list' do
      haml_tag :li, 'Menu' ,class: 'nav-header'
      yield if block_given?
    end
  end
end