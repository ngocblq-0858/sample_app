require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, I18n.t("test.common.base_title")
    assert_equal full_title("Help"),
      I18n.t("test.helper.application.help_title")
  end
end
