Given /^an Employer$/ do
  login_page = LoginPage.new(@driver)
  login_user = YAML.load_file('config/users.yml')['test_user']
  login_page.login(login_user['username'], login_user['password'])
end

Given /^I am on the (.+) page$/ do |page_name|
  page_object = "#{page_name.gsub(' ', '')}Page"
  @page = Object.const_get(page_object).new(@driver)
  @page.page_header.should eq page_name
end

When /^I select Add Employee$/ do
  @page.add_employee
end

When(/^I select the action "(.+)"$/) do |action|
  used_row = @page.employee_actions(action.downcase)
  @current_user = @page.to_employee_factory(used_row)
end

When(/^I add a dependent for a user$/) do
  used_row = @page.employee_actions('edit')
  @user = @page.to_employee_factory(used_row)
  @user.dependents += 1
  @page.populate_employee(@user)
end

Then(/^(.+) does not begin with "(.+)" or "(.+)"$/) do |field, value1, value2|
  field.downcase!.gsub!(' ', '_')
  if @user.respond_to?(field)
    @user.send(field).sub! /^[#{value1}#{value2}]*/, ''
  else
    raise "#{@user} does not have field #{field}"
  end
  @page.populate_employee(@user)
end

Then(/^(.+) begins with "(.+)" or "(.+)"$/) do |field, value1, value2|
  field.downcase!.gsub!(' ', '_')
  if @user.respond_to?(field)
    if @user.send(field) !=~ /^[#{value1}#{value2}]/
      @user.send(field).prepend(value1)
    end
  else
    raise "#{@user} does not have field #{field}"
  end
  @page.populate_employee(@user)
end

Then /^the employee saves the information$/ do
  @page.employee_submit
end

Then /^I should see the employee in the table$/ do
  @user_data = @page.row(@user)
  @user_data.should_not be_nil
end

Then /^the benefit cost calculations are correct$/ do
  discount = @user.discount

  salary = @user_data['Salary'].text.to_i
  dependents = @user_data['Dependents'].text.to_i
  dependent_cost = dependents * @user.cost_per_dependent.to_f
  expected_benefit_cost = (dependent_cost + @user.annual_benefits_cost)*(1-discount)
  expected_gross_pay = @user.base_salary/@pay_periods_per_year
  expected_benefit_per_period = (expected_benefit_cost/@pay_periods_per_year).round(2)

  salary.should eq @user.base_salary
  @user_data['Gross Pay'].text.to_i.should eq expected_gross_pay
  @user_data['Benefit Cost'].text.to_f.should eql expected_benefit_per_period
  @user_data['Net Pay'].text.to_f.should eql expected_gross_pay - expected_benefit_per_period
end

Then(/^the employee has a (\d+)% Discount$/) do |percent|
  @user.discount = (percent.to_f)/100
end

Then(/^I can edit employee details$/) do
  @page.fields_visible
  @user = FactoryGirl.create(:employee)
  @page.populate_employee(@user)

end

Then(/^the data should change in the table$/) do
  @user_data = @page.row(@user)
  @user_data.should_not be_nil
  # @user_data['First Name'].text.should eq @user.first_name
  # @user_data['last Name'].text.should eq @user.last_name
  @user_data['Dependents'].text.to_i.should eq @user.dependents
end

Then(/^the employee should be deleted$/) do
  @page.wait_on_spinner
  @user_data = @page.row(@current_user)
  @user_data.should be_nil
end

Then /^I should be able to enter employee details$/ do
  @page.fields_visible
  @user = FactoryGirl.create(:employee)
end
