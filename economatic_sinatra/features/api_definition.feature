Feature: API Definition
  In order to use the api
  As a front end developer
  I want to know which calls are available

  Scenario: View definition
    When I go to '/'
    Then I see 'economatic'
    And I see 'account_balance_enquiry'

