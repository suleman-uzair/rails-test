require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert_equal "a s", Plurimath::Math.parse("as", :asciimath).to_asciimath
  end
end
