Feature:
  In order to pay money to other people in the system
  As an account operator
  I want to be able to transfer money to another account

  Background:
    Given a bank
    Given account FrodoSavings
    Given account BilboChecking
    Given a user Gandhalf who can operate FrodoSavings account

  Scenario: Succesfully transfer money
    When Gandhalf transfers $50 from FrodoSavings account to BilboChecking account
    Then FrodoSavings account has a balance of $-50
    Then BilboChecking account has a balance of $50
    Then FrodoSavings account has a $50 transaction by Gandhalf to BilboChecking account in the transaction log
    Then BilboChecking account has a $50 transaction by Gandhalf from FrodoSavings account in the transaction log

  Scenario: Restrict access to accounts
    Given a user Gollum who can not operate FrodoSavings account
    When Gollum transfers $50 from FrodoSavings account to BilboChecking account an error should be raised
    Then FrodoSavings account has a balance of $0
    Then BilboChecking account has a balance of $0

  Scenario: Overdraft limits
    Given FrodoSavings account has an overdraft limit of $-30
    When Gandhalf transfers $50 from FrodoSavings account to BilboChecking account an error should be raised
    Then FrodoSavings account has a balance of $0
    Then BilboChecking account has a balance of $0
