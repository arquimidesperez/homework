require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url, as: :json
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { address: @employee.address, birth_date: @employee.birth_date, city: @employee.city, country: @employee.country, email: @employee.email, fax: @employee.fax, first_name: @employee.first_name, hire_date: @employee.hire_date, last_name: @employee.last_name, phone: @employee.phone, postal_code: @employee.postal_code, reports_to: @employee.reports_to, state: @employee.state, title: @employee.title } }, as: :json
    end

    assert_response 201
  end

  test "should show employee" do
    get employee_url(@employee), as: :json
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { address: @employee.address, birth_date: @employee.birth_date, city: @employee.city, country: @employee.country, email: @employee.email, fax: @employee.fax, first_name: @employee.first_name, hire_date: @employee.hire_date, last_name: @employee.last_name, phone: @employee.phone, postal_code: @employee.postal_code, reports_to: @employee.reports_to, state: @employee.state, title: @employee.title } }, as: :json
    assert_response 200
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee), as: :json
    end

    assert_response 204
  end
end
