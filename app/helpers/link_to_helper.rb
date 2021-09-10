module LinkToHelper

  # override Rails link_to method
  # nothing fancy happening here other than allowing users to pass blocks to link_to
  def link_to(name = nil, options = nil, html_options = {}, &block)
    if block_given?
      html_options = options
      options = name
      return super(options, merge_modal_html_options(html_options).to_h, &block)
    else
      super(name, options, merge_modal_html_options(html_options).to_h)
    end
  end

  private

  def merge_modal_html_options(html_options)
    # check for modal: true
    return html_options if nil == html_options || true != html_options[:modal]

    # delete modal html option (see line above)
    html_options.delete(:modal)

    # add remote: true since this is an ajax request
    html_options[:remote] = true

    # add stimulus data attributes
    (html_options[:data] ||= {}).merge!(

       # point to stimulus controller
      controller: 'ajax-modal',

      # wire up stimulus actions
      action: [
        'ajax:success->ajax-modal#success',
        'ajax:error->ajax-modal#error'
      ].join(" "),

      # disable turbolinks (if you are using turbolinks)
      turbolinks: false
    )

    html_options
  end
end