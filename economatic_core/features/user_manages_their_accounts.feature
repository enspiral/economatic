Feature: A user can manage their accounts
  In order to have accounts for any purpose I might need
  As a regular user
  I want to be able to create, edit and close accounts

  Background:
    Given a bank ShireSavingsAndLoan
    Given account SamwiseSalary in ShireSavingsAndLoan

  Scenario: Creating an account
    Given a user Bilbo
    When Bilbo creates an account in ShireSavingsAndLoan with:
      | name        | Birthday expenses                          |
      | description | A short term account used to plan my party |
    Then Bilbo's account list for ShireSavingsAndLoan should be:
      | name              | description                                | balance |
      | Birthday expenses | A short term account used to plan my party | $0.0    |

    