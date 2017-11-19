using Telegram

module U1F171
  class Bot
    attr_accessor :token
    def initialize;end
    
    def replace
      Telegram::Bot::Client.run @token do |bot|
        bot.listen do |message|
          case message.text
          when /.*b.*/
            bot.api.edit_message_text(
              chat_id: message.chat.id,
              message_id: message.message_id,
              text: message.text.gsub('b', "\u{1f171}").gsub('B', "\u{1f171}")
            )
          end
        end
      end
    end

    def correction
      Telegram::Bot::Client.run @token do |bot|
        begin
          bot.listen do |message|
            case message.text.nil? ? "" : message.text.downcase
            when /.*b.*/
              bot.api.send_message(
                chat_id: message.chat.id,
                reply_to_message_id: message.message_id,
                text: "_Did you mean?_\n\n#{message.text.gsub('b', "\u{1f171}").gsub('B', "\u{1f171}")}",
                parse_mode: 'Markdown'
              )
            end
          end
        rescue Telegram::Bot::Exceptions::ResponseError => e
          puts "Oppsie, an error while listening:"
          puts e.backtrace
          retry
        end
      end
    end

    private def say string, instance=nil
      if intance.nil?
        Telegram::Bot::Client.run @token do |bot|
          bot.api.send_message(
            chat_id: message.chat.id,
            text: string
          )
        end
        return string
      end
      
      instance.api.send_message chat_id: message.chat.id, text: string
      string
    end
  end
end
