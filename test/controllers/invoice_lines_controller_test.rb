require "test_helper"

class InvoiceLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice_line = invoice_lines(:one)
  end

  test "should get index" do
    get invoice_lines_url, as: :json
    assert_response :success
  end

  test "should create invoice_line" do
    assert_difference('InvoiceLine.count') do
      post invoice_lines_url, params: { invoice_line: { invoice_id: @invoice_line.invoice_id, quantity: @invoice_line.quantity, track_id: @invoice_line.track_id, unit_price: @invoice_line.unit_price } }, as: :json
    end

    assert_response 201
  end

  test "should show invoice_line" do
    get invoice_line_url(@invoice_line), as: :json
    assert_response :success
  end

  test "should update invoice_line" do
    patch invoice_line_url(@invoice_line), params: { invoice_line: { invoice_id: @invoice_line.invoice_id, quantity: @invoice_line.quantity, track_id: @invoice_line.track_id, unit_price: @invoice_line.unit_price } }, as: :json
    assert_response 200
  end

  test "should destroy invoice_line" do
    assert_difference('InvoiceLine.count', -1) do
      delete invoice_line_url(@invoice_line), as: :json
    end

    assert_response 204
  end
end
