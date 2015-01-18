module LayoutHelper
  def flash_messages(opts={})
    @layout_flash = opts.fetch(:layout_flash) { true }

    capture do
      flash.each do |name, msg|
        concat content_tag(:div, class: "alert alert-dismissable #{bootstrap_class_for(name)}", role: "alert"){
          concat content_tag(:button, type: "button", class: "close", data: {dismiss: "alert"}){
            concat content_tag(:span, "aria-hidden" => "true"){ "&times;".html_safe }
            concat content_tag(:span, "Close", class: "sr-only")
          }
          concat msg
        }
      end
    end
  end

  def show_layout_flash?
    @layout_flash.nil? ? true : @layout_flash
  end   

  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-error"
      when "alert"
        "alert-block"
      when "notice"
        "alert-info"
    end
  end 
end