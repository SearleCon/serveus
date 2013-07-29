module BootstrapHelper

  TABLE_CLASSES = { bordered: 'table-bordered', striped: 'table-striped', hover: 'table-hover', condensed: 'table-condensed' }


  def glyph(*names)
    content_tag :i, nil, class: names.map{|name| "icon-#{name.to_s.gsub('_','-')}" }
  end

  def nav_list(html_options = {})
    html_options.merge!(class: 'nav nav-list')
    haml_tag :ul, html_options do
      haml_tag :li, 'Menu' ,class: 'nav-header'
      yield if block_given?
    end
  end

  def bootstrap_table(headers: [], types: [], html_options: {})
    classes = []
    classes << table_classes(types)
    classes << html_options[:class]
    haml_tag :table, id: html_options[:id], class: classes do
      haml_tag :thead do
        haml_tag :tr do
          headers.each { |h| haml_tag :th, h }
        end
      end
      haml_tag :tbody do
        yield if block_given?
      end
    end

  end

  def table_classes(classes)
    table_classes = %w(table)
    classes.each do |c|
      if TABLE_CLASSES.has_key?(c)
       table_classes << TABLE_CLASSES[c]
      else
      table_classes << c.to_s
      end
    end
    table_classes
  end

  def table_headers(headers)
    haml_tag :thead do
      haml_tag :tr do
        headers.each { |h| haml_tag :th, h }
      end
    end
  end

  def popover(help_key)
     simple_format(I18n.t help_key, scope: [:help])
  end
end