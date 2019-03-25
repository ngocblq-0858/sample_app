require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", add_locale_to_link(root_path), count: 2
    assert_select "a[href=?]", add_locale_to_link(help_path)
    assert_select "a[href=?]", add_locale_to_link(about_path)
    assert_select "a[href=?]", add_locale_to_link(contact_path)
    get contact_path
    assert_select "title", full_title("Contact")
  end

  def add_locale_to_link link
    link + "?locale=" + I18n.locale.to_s
  end
end
