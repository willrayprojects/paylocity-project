class BenefitsDashboardPage < BasePage
  attr_accessor :edit_employee, :x_employee

  div(:page_header, class: 'jumbotron')
  button(:add_employee, id: 'btnAddEmployee')
  table(:table_employees, id: 'employee-table')
  div(:spinner, class: 'spinner')

  # Add Employee Overlay
  div(:add_employee_modal, id: 'addEmployeeModal')
  div(:backdrop_modal, class: 'modal-backdrop-fade')
  text_field(:employee_first_name, xpath: '//div[label[@for="firstname"]]//input')
  text_field(:employee_last_name, xpath: '//div[label[@for="lastname"]]//input')
  text_field(:employee_dependents, xpath: '//div[label[@for="dependents"]]//input')
  button(:employee_submit, css: 'div#addEmployeeModal button.btn-primary')



  def initialize_page
    self.edit_employee = 'btnEdit'
    self.x_employee = 'btnDelete'
  end

  def populate_employee(user)
    add_employee_modal_element.when_visible(5)
    self.employee_first_name = user.first_name
    self.employee_last_name = user.last_name
    self.employee_dependents = user.dependents
  end

  def fields_visible()
    add_employee_modal_element.when_visible(5)

    # TODO: these elements should be instance variables, so I don't have to manually aggregate
    elements = [
      employee_first_name_element,
      employee_last_name_element,
      employee_submit_element
    ]

    elements.each do |element|
      element.should be_visible
    end
  end

  def row(user)
    table_employees_element[user.first_name]
  end

  def wait_on_spinner
    begin
      spinner_element.when_not_visible(5)
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      $LOG.info 'Spinner went stale, which is what happens when this is removed from the DOM after deletion'
    end
  end

  def employee_actions(action)
    row = table_employees_element[1]
    actions = row['Actions']
    actions.link_element(id: self.send("#{action}_employee")).click

    return row
  end

  def to_employee_factory(row)
    FactoryGirl.create(:employee,
                       first_name: row['First Name'].text,
                       last_name: row['Last Name'].text,
                       dependents: row['Dependents'].text.to_i)
  end
end