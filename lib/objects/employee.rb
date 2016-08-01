
class Employee
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :dependents, :base_salary, :annual_benefits_cost, :cost_per_dependent
  attr_accessor :discount
end