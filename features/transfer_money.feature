Feature:
  In order to pay money to other people in the system
  As an account operator
  I want to be able to transfer money to another account

  Scenario: Succesfully transfer money
    Given account FrodoSavings with $100 in it
    Given account BilboChecking with $20 in it
    Given a user Gandhalf who can operate FrodoSavings
    When Gandhalf transfers $50 from FrodoSaving to BilboChecking
    Then FrodoSavings has $50
    Then BilboChecking has $70
    Then FrodoSaving has a $50 transaction by Gandhalf to BilboChecking in the transaction log
    Then BilboChecking has a $50 transaction by Gandhalf from FrodoSaving in the transaction log
