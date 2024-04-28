module FlashMessagesHelper
  def tailwind_class_for(flash_type)
    case flash_type
    when "success"
      "bg-teal-100 border border-teal-500 text-teal-900"
    when "error"
      "bg-red-100 border border-red-400 text-red-700"
    when "notice"
      "bg-blue-100 border border-blue-500 text-blue-700"
    else
      flash_type
    end
  end

  def flash_messages
    safe_join(
      flash.map do |msg_type, message|
        content_tag(:div,
                    data: { controller: "flash-message", target: "flash-message.message" },
                    class: "px-4 py-2 max-w-2xl rounded relative #{tailwind_class_for(msg_type)}") do
          content_tag(:div, class: "flex justify-between flex-row-reverse") do
            content_tag(:button, "×",
                        data: { action: "click->flash-message#close" },
                        class: "focus:outline-none") + message
          end
        end
      end
    ).tap { flash.clear }
  end
end
