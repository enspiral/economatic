Feature:
  In order to pay money to other people in the system
  As an account owner
  I want to be able to transfer money to another account

  Scenario: Succesfully transfer money
    Given "Frodo" has an account with $100 in it
    Given "Bilbo" has an acount with $20 in it
    When I transfer $50 from "Frodo" to "Bilbo"
    Then "Frodo" should $50
    Then "Bilbo" should have $70
    Then "Frodo" should have a $50 transaction to "Bilbo" in the transaction log
    Then "Bilbo" should have a $50 transaction from "Frodo" in the transaction log
