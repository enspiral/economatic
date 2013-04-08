Feature:
  So that money can enter and leave the bank
  As a bank owner
  I want to be able to create and destroy money

  Background:
    Given a bank MI6
    And external account PublicGrants in MI6
    And external account FieldExpenses in MI6
    And account Operations in MI6
    And account BondGoldCard in MI6 with an overdraft limit of $-10000000
    And a user M who can administer MI6
    And a user Bond who can operate BondGoldCard account

  Scenario: Successfully create money
    When M transfers $10000000 from PublicGrants to Operations with description "Budget for 1967"
    And M transfers $500 from Operations to BondGoldCard
    Then Total money in bank is $10000000
    And PublicGrants has a balance of $-10000000
    And BondGoldCard has a balance of $500

  Scenario: Instruct administrator to process payments
    When Bond transfers $800000 from BondGoldCard to FieldExpenses with description "Ferrari"
    Then MI6 has a pending transaction from BondGoldCard to FieldExpenses for $8000000
    And FieldExpenses has a balance of $0
    And BondGoldCard has a balance of $-800000
    And MI6 has pending transactions totaling $800000

  Scenario: Administrator processes payment
    Given Total money in bank is $0
    And MI6 has a pending transaction from BondGoldCard to FieldExpenses for $50000 with description "Martinis"
    When M approves transaction "Martinis" with description "Oh James"
    Then BondGoldCard has a balance of $-50000
    And Total money in bank is $-50000
    And MI6 has pending transactions totaling $0
    And FieldExpenses has a balance of $50000
