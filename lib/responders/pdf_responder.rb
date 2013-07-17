module Responders
  module PDFResponder
    def initialize(controller, resources, options={})
      super
    end

    def to_pdf
      render pdf: file_name, layout: 'pdf.html'
    end

    protected
    def file_name
      "#{Time.zone.now.to_i}_#{controller.controller_name}"
    end
  end
end