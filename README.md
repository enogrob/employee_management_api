### Session: Developing and Testing a Basic RESTful API in Ruby on Rails

#### Objective:
Create a RESTful API using Ruby on Rails to manage a simple "Employee Management" system. The API will support basic CRUD operations (Create, Read, Update, Delete) for managing employee records. This session will walk through each step and provide tests for validating the API.

#### Prerequisites:
Ensure you have Ruby (version 3.x) and Rails (version 7.x) installed.

---

### Step 1: Set Up the Rails Project

1. Open a terminal.
2. Create a new Rails API-only project by running:
   ```bash
   rails new EmployeeManagementAPI --api
   cd EmployeeManagementAPI
   ```

### Step 2: Generate the Employee Resource

Generate a model and controller for `Employee`:
```bash
rails generate scaffold Employee name:string position:string department:string salary:decimal
```

This command will create:
- Model file: `app/models/employee.rb`
- Migration file for the database schema.
- Controller file with actions for CRUD operations.
  
### Step 3: Set Up Database and Run Migrations

1. Configure the database in `config/database.yml` (use SQLite for simplicity).
2. Run the migration:
   ```bash
   rails db:create
   rails db:migrate
   ```

### Step 4: Define Routes

In `config/routes.rb`, define RESTful routes for the `Employee` resource:
```ruby
Rails.application.routes.draw do
  resources :employees
end
```

### Step 5: Implement CRUD Actions (Already Scaffolded)

The `scaffold` generator has already created CRUD actions in `app/controllers/employees_controller.rb`:
- `index`: List all employees
- `show`: Show a single employee
- `create`: Add a new employee
- `update`: Modify an existing employee
- `destroy`: Delete an employee

### Step 6: Add Validations to the Employee Model

In `app/models/employee.rb`, add basic validations:
```ruby
class Employee < ApplicationRecord
  validates :name, presence: true
  validates :position, presence: true
  validates :department, presence: true
  validates :salary, numericality: { greater_than: 0 }
end
```

---

### Step 7: Test the API Endpoints

1. **Start the Rails Server:**
   ```bash
   rails server
   ```

2. **Testing with Postman or Curl:**

   - **Create an Employee:**
     ```bash
     curl -X POST -H "Content-Type: application/json" \
     -d '{"name":"John Doe","position":"Developer","department":"Engineering","salary":5000}' \
     http://localhost:3000/employees
     ```

   - **Read All Employees:**
     ```bash
     curl http://localhost:3000/employees
     ```

   - **Read a Single Employee:**
     ```bash
     curl http://localhost:3000/employees/1
     ```

   - **Update an Employee:**
     ```bash
     curl -X PUT -H "Content-Type: application/json" \
     -d '{"name":"John Smith","salary":5500}' \
     http://localhost:3000/employees/1
     ```

   - **Delete an Employee:**
     ```bash
     curl -X DELETE http://localhost:3000/employees/1
     ```

### Step 8: Automated Testing

Add tests in `test/controllers/employees_controller_test.rb` to ensure endpoints work as expected:

```ruby
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
    assert_difference("Employee.count") do
      post employees_url, params: { employee: { name: "Jane Doe", position: "Manager", department: "Sales", salary: 7000 } }, as: :json
    end
    assert_response :created
  end

  test "should show employee" do
    get employee_url(@employee), as: :json
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { salary: 7500 } }, as: :json
    assert_response :success
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete employee_url(@employee), as: :json
    end
    assert_response :no_content
  end
end
```

Run the tests:
```bash
rails test
```

### Step 9: Review and Refactor

After testing, review the code for any potential improvements in code quality, security, or performance.

---

### Versions Used
- **Ruby:** 3.x
- **Rails:** 7.x
>>>>>>> 4ba0d3d (ror-setup)
