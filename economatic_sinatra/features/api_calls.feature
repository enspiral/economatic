Feature: API Calls
  In order to access the app
  As a front end developer
  I want to call methods via the api

  Background:
    Given a bank ShireTimebank
    Given account FrodoSavings in ShireTimebank
    Given a user Gandhalf who can operate FrodoSavings account

  Scenario: View definition
    When I go to '/economatic/list_accounts?bank_id=1&user_id=1'
    Then I see 'FrodoSavings'

