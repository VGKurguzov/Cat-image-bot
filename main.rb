require 'telegram/bot'
require 'telegram/bot/types'
require_relative 'cat_api'

token = '1329024204:AAHEqtG16n0k66qw1UgIHvIuZigqHq4u1j0'

def get_new_cat()
  cat = CatApi.new()
  return cat.get_url_image.to_s
end

Telegram::Bot::Client.run(token) do |bot|

  bot.listen do |rqst|
    Thread.start(rqst) do |request|
    case rqst.text
        when '/start'
          kb = [
              Telegram::Bot::Types::KeyboardButton.new(text: 'Получить нового котика 🐈')
          ]
          markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: TRUE)
          bot.api.send_message(chat_id: request.chat.id, text: "Привет! Меня зовут CatImg_bot и я могу отправлять тебе картиночки няшных котиков <3! \n Например вот:",
                               )
          bot.api.send_photo(chat_id: request.chat.id, photo: get_new_cat)
          bot.api.send_message(chat_id: request.chat.id, text: "Если захочешь ещё картинок, просто нажми на кнопку 'Получить нового котика 🐈'!",
                               reply_markup: markup)
        when 'Получить нового котика 🐈'
          bot.api.send_photo(chat_id: request.chat.id, photo: get_new_cat)
    end
    end
  end
end

