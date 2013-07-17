module WickedPdfHelper
  def wicked_pdf_stylesheet_link_tag(*sources)
    sources.collect { |source|
      asset = Rails.application.assets.find_asset("#{source}.css")
      if asset.nil?
        raise "could not find asset for #{source}.css"
      else
        "<style type='text/css'>#{asset.body}</style>"
      end
    }.join("\n").gsub(/url\(['"](.+)['"]\)(.+)/,%[url("#{wicked_pdf_image_location("\\1")}")\\2]).html_safe
  end

  def wicked_pdf_image_tag(img, options={})
    asset = Rails.application.assets.find_asset(img)
    image_tag "file://#{asset.pathname.to_s}", options
  end

  def wicked_pdf_javascript_src_tag(jsfile, options={})
    asset = Rails.application.assets.find_asset(jsfile)
    javascript_include_tag "file://#{asset.pathname.to_s}", options
  end

  def wicked_pdf_javascript_include_tag(*sources)
    sources.collect{ |source| "<script type='text/javascript'>#{Rails.application.assets.find_asset(source+".js")}</script>" }.join("\n").html_safe
  end
end