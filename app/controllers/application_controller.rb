class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = extract_locale_from_tld || I18n.default_locale
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split(".").last
    locales = I18n.available_locales.map(&:to_s)
    locales.include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def hello
    render html: "Hello, world!"
  end
end
