Feature: A user can manage their accounts
  In order to have accounts for any purpose I might need
  As a regular user
  I want to be able to create, edit and close accounts

  Background:
    Given a bank ShireSavingsAndLoan
    Given account SamwiseSalary in ShireSavingsAndLoan
    Given a user Samwise who can operate SamwiseSalary account

  Scenario: Creating an account shows it in list
    Given a user Bilbo
    When Bilbo creates an account in ShireSavingsAndLoan with:
      | name        | Birthday expenses                          |
      | description | A short term account used to plan my party |
    Then Bilbo's account list for ShireSavingsAndLoan should be:
      | name              | description                                | balance |
      | Birthday expenses | A short term account used to plan my party | $0.0    |

  Scenario: Updating an account changes it's details in the list
    When Samwise updates SamwiseSalary account with:
      | name        | My salary account   |
      | description | Where bilbo pays me |
    Then Samwise's account list for ShireSavingsAndLoan should be:
      | name              | description         | balance |
      | My salary account | Where bilbo pays me | $0.0    |
