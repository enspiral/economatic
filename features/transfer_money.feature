Feature:
  In order to pay money to other people in the system
  As an account operator
  I want to be able to transfer money to another account

  Scenario: Succesfully transfer money
    Given a bank
    Given account FrodoSavings
    Given account BilboChecking
    Given a user Gandhalf who can operate FrodoSavings
    When Gandhalf transfers $50 from FrodoSavings to BilboChecking
    Then FrodoSavings account has $-50
    Then BilboChecking account has $50
    Then FrodoSavings has a $50 transaction by Gandhalf to BilboChecking in the transaction log
    Then BilboChecking has a $50 transaction by Gandhalf from FrodoSavings in the transaction log
