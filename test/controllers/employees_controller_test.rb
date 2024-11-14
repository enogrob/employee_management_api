require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index and list all employees" do
    get employees_url, as: :json
    assert_response :success
    assert_not_nil response.parsed_body, "Expected response to contain employee list"
    assert response.parsed_body.is_a?(Array), "Expected response body to be an array"
  end

  test "should create a new employee with valid attributes" do
    assert_difference("Employee.count", 1, "An employee should be added to the database") do
      post employees_url, params: { employee: { name: "Jane Doe", position: "Manager", department: "Sales", salary: 7000 } }, as: :json
    end
    assert_response :created
    assert_equal "Jane Doe", Employee.last.name, "Employee name should match the one created"
  end

  test "should show a specific employee by ID" do
    get employee_url(@employee), as: :json
    assert_response :success
    assert_equal @employee.name, response.parsed_body["name"], "Expected the employee name to match"
  end

  test "should update employee with valid attributes" do
    new_salary = 7500
    patch employee_url(@employee), params: { employee: { salary: new_salary } }, as: :json
    assert_response :success
    @employee.reload
    assert_equal new_salary, @employee.salary, "Expected the employee salary to be updated"
  end

  test "should destroy employee and reduce count by one" do
    assert_difference("Employee.count", -1, "An employee should be removed from the database") do
      delete employee_url(@employee), as: :json
    end
    assert_response :no_content
    assert_raises(ActiveRecord::RecordNotFound) { Employee.find(@employee.id) }
  end

  test "should not create employee with invalid data" do
    assert_no_difference("Employee.count", "An invalid employee record should not be saved") do
      post employees_url, params: { employee: { name: "", position: "", salary: -100 } }, as: :json
    end
    assert_response :unprocessable_entity
    assert response.parsed_body["errors"].is_a?(Array), "Expected errors to be an array"
    assert_includes response.parsed_body["errors"], "Name can't be blank", "Expected error for missing name"
    assert_includes response.parsed_body["errors"], "Position can't be blank", "Expected error for missing position"
    assert_includes response.parsed_body["errors"], "Salary must be greater than 0", "Expected error for invalid salary"
  end
end
