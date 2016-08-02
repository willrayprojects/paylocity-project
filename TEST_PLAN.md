### Paylocity Coding Challenge Test Plan

#### Objectives
To test the integrity of a small example application for production readiness.

Automate any tests that are automatable. 

#### Functionality Included in Product
This build contains the following functionality to exercise and verify.
* Benefits Dashboard
  * Add Employee
    * First Name
    * Last Name
    * Dependents
  * Employees Table
    * Fields
      * ID 
      * Last Name
      * First Name
      * Salary (52,000)
      * Dependents
      * Gross Pay (Salary/payperiods(26))
      * Benefit Cost ((Annual Benefits(1,000) + Dependent Benefits(500*Dependents))/payperiods(26) )
      * Net Pay (Gross Pay - Benefit Cost)
    * Actions
       * Edit (Wrench Icon)
       * Delete (X Icon)

#### Exit Criteria

* No critical or high defects.
* Any quantity of automation
  * Typically would like to have a percent coverage, but for the scope and timeframe allowed, any is sufficient.
  
#### Manual Testing Considerations
* Usability - Confirm that functionality works as you would expect it to
* Responsiveness - Confirm that the various resolutions work as expected
* Areas not covered by end to end automation

#### Automation Considerations
* Any automatable manual test cases

#### Functionality to develop tests for
* Resolution
* Editable Fields
  * Required (if any)
  * Length
  * Data types
  * Data stores properly
* Actions
  * Add Employee
  * Edit Employee
  * Delete Employee
* Table Data
  * Proper location
  * Proper calculations
