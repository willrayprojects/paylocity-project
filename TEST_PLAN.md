### Paylocity Coding Challenge Test Plan
[Objectives](#objectives)

[Functionality Included in Product](#functionality-included-in-product)

[Exit Criteria](#exit-criteria)

[Risks](#risks)

[Manual Testing Considerations](#manual-testing-considerations)

[Automation Considerations](#automation-considerations)

[Functionality to develop tests for](#functionality-to-develop-tests-for)
[Manual Test Cases](#manual-test-cases)
  * [Data Mappings](#data-mappings)
  * [Discount for Existing User](#discount-for-existing-user)
  * [Resolution changes do not impact user experience adversely](#Resolution-changes-do-not-impact-user-experience-adversely)

---
## Objectives
To test the integrity of a small example application for production readiness.

Automate any tests that are automatable. 

### Functionality Included in Product
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
      * Gross Pay ( Salary/payperiods(26) )
      * Benefit Cost ( (Annual Benefits(1,000) + Dependent Benefits(500*Dependents))/payperiods(26) )
      * Net Pay ( Gross Pay - Benefit Cost )
    * Actions
       * Edit (Wrench Icon)
       * Delete (X Icon)
    * Other Considerations
       * Users with first name beginning with "A" should have a discount

### Exit Criteria
* No critical or high defects.
* Any quantity of automation
  * Typically would like to have a percent coverage, but for the scope and timeframe allowed, any is sufficient.

### Risks
  * Given this is just a test project, I doubt any of the bugs will be fixed :)
  * Due to timeframe allowed
    * Not all automatable tests will be practical to test
    * Much of the testing was exploratory, and susceptible to regressions or misses later
  
### Manual Testing Considerations
* Usability - Confirm that functionality works as you would expect it to
* Responsiveness - Confirm that the various resolutions work as expected
* Areas not covered by end to end automation

### Automation Considerations
* Any automatable manual test cases

### Functionality to develop tests for
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


### Manual Test Cases
#### Data Mappings
#####Pre-requisite
User is logged in and on Benefits Dashboard

##### Steps
  1. Click "Add Employee"
  2. Enter a "First Name", "Last Name", and "Dependents" field value (e.g. "Ray", "Williams", 1)
  3. Click "Submit"
  4. Observe that the fields map to expected columns

##### Expected Result

First name should be in column "First Name", Last Name in "Last Name", and dependent number in column "Dependents"

#### Discount for Existing User
##### Pre-requisite 
User is logged in and on Benefits Dashboard, and a user exists

##### Steps
  1. Edit User
  2. Change First Name to begin with "A" (e.g. "Ashley")
  3. Click "Submit"
  4. Observe that the "Benefit Cost", and "Net Pay" columns update

##### Expected Result
"Benefit Cost" and "Net Pay" columns should now reflect a 10% discount.

#### Resolution changes do not impact user experience adversely
##### Pre-requisite
User is logged in and on Benefits Dashboard. Reference [this page](http://mediag.com/news/popular-screen-resolutions-designing-for-all/) for common mobile and tablet resolutions.

##### Steps
  1. Change the resolution to be of a mobile phone width and height, and observe response
  2. Change the resolution to be of a tablet width and height, and observe response
  3. Open "Add Employee"
  4. Enter a "First Name", "Last Name", and "Dependents" field value (e.g. "Ray", "Williams", 1)
  5. Change the resolution to be of a mobile phone width and height
  6. Change the resolution to be of a tablet width and height, and observe response

##### Expected Result
The change of resolution sizes should not adversely impact user experience on steps 1,2,5, and 6.
First name should be in column "First Name", Last Name in "Last Name", and dependent number in column "Dependents"
