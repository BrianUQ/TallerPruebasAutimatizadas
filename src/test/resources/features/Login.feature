Feature: Login functionality

  Scenario: Successful login
    Given I have a valid credentials
    When I send a POST request to the login endpoint
    Then I should receive a successful message

  Scenario: Invalid credentials
    Given I have invalid credentials
    When I send a POST request to the login endpoint
    Then I should receive an error message indicating invalid credentials

  Scenario: Server error:
    Given the login endpoint is experiencing a server error
    When I send a POST request to the login endpoint
    Then I should receive an error message indicating a server error

  Scenario: Password reset
    Given I have requested a password reset
    When I enter my email address and the verification code
    Then I should be able to reset my password

  Scenario: Successful token
    Given I have a valid credentials
    When I send a POST request to the login endpoint
    Then I should receive an access token

  Scenario: Successful register
    Given that the user registration endpoint is available
    When a new user is registered with valid credentials
    Then the registration should be successful

  Scenario: Registration with Duplicate Email
    Given that the user registration endpoint is available
    When the user registers with valid with a valid email address that already exists
    Then the registration should fail with an error message indicating that the email is already in use

  Scenario: Registration with Invalid Email Format:
    Given that the user registration endpoint is available
    When the user registers with an invalid email address
    Then the registration should fail with an error message indicating that the email is invalid

  Scenario: Registration with Weak Password
    Given that the user registration endpoint is available
    When the user registers with a valid email address and a weak password
    Then the registration should fail with an error message indicating that the password is weak

  Scenario: Successful Delete
    Given I have a valid username and password
    When I delet the user whit id 1
    Then the user whit id 1 should no exist

  Scenario: Deletion of Non-Existing User:
    Given I have a valid username and password
    When I try to delete a user with a non-existent ID
    Then the deletion should fail with an error message indicating that the user does not exist

  Scenario: Deletion of System User
    Given I have a valid username and password
    When I try to delete a system user
    Then the deletion should fail with an error message indicating that the user cannot be deleted

  Scenario: Successful Update
    Given I have a valid username and password
    When the name of the user with ID 1 is updated to "New Name"
    Then  the user with ID 1 should have the name "New Name"

  Scenario: Updating Required Fields
    Given I have a valid username and password
    When I try to update a required field of the user with ID 1 to an empty value
    Then the update should fail with an error message indicating that the field is required

  Scenario: Updating Non-Existing User:
    Given I have a valid username and password
    When I try to update a user with a non-existent ID
    Then the update should fail with an error message indicating that the user does not exist

  Scenario: Data Validation
    Given I have a valid username and password
    When I try to update a field with invalid data
    Then the update should fail with an error message indicating that the data is invalid