using Telegram

module U1F171
  B = "\u{1f171}"
  TRANSFROM = {
    :extreme => -> s { s.gsub(/d|D|b|B|p|P/, B).split(' ').map { |ss|; ss[0] = B if ss.size > 1; ss }.join(' ') },
    :plosive => -> s { s.gsub /b|B|p|P|f|F/, B },
    :simple  => -> s { s.gsub /b|B/,         B }
  }

  class Bot
    attr_accessor :token
    
    def replace
      Telegram::Bot::Client.run @token do |bot|
        bot.listen do |message|
          case message.text
          when /.*/
            bot.api.edit_message_text(
              chat_id: message.chat.id,
              message_id: message.message_id,
              text: TRANSFROM[(ARGV[0] || :plosive).to_sym].call(message.text)
            )
          end
        end
      end
    end

    def correction
      quiet = false
      Telegram::Bot::Client.run @token do |bot|
        begin
          bot.listen do |message|
            case message.text.nil? ? "" : message.text.downcase
            when /\/silence/
              bot.api.send_message chat_id: message.chat.id, text: "Ok, I'll shu#{B} u#{B}."
              quiet = true
            when /\/unsilence/
              bot.api.send_message chat_id: message.chat.id, text: "Yeah #{B}oiiiiiiii!"
              quiet = false
            when /.*/
              transformed = TRANSFROM[(ARGV[0] || :plosive).to_sym].(message.text)
              unless quiet || message.text == transformed
                bot.api.send_message(
                  chat_id: message.chat.id,
                  reply_to_message_id: message.message_id,
                  text: "_Did you mean?_\n\n#{transformed}",
                  parse_mode: 'Markdown'
                )
              end
            end
          end
        rescue Exception => e
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
