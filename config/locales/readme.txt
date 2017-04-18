同名ファイルに上書き

config/application.rbに以下の部分を書き換える
module Profy
  class Application < Rails::Application
    config.i18n.default_locale = :ja #コメントアウトしている場合は外すだけで良い。
  end
end