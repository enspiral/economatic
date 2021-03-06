Feature: Can transfer money between bank and external sources
  So that money can enter and leave the bank
  As a bank owner
  I want to be able to manage external accounts and transfer money between them and internal ones

  Background:
    Given a bank MI6
    Given external account PublicGrants in MI6
    Given external account FieldExpenses in MI6
    Given account Operations in MI6
    Given account BondGoldCard in MI6
    Given BondGoldCard account has an overdraft limit of $-1,000,000
    Given a user M who can administer MI6 bank
    Given a user Bond who can operate BondGoldCard account

  Scenario: Transfer money in from external account
    When M transfers $10,000,000 from PublicGrants account to Operations account with description "Budget for 1967"
    Then Total money in MI6 bank is $10,000,000
    Then PublicGrants account has a balance of $-10,000,000
    Then Operations account has a balance of $10,000,000

  Scenario: Transfer money out to external account and it is held as pending
    When Bond transfers $800,000 from BondGoldCard account to FieldExpenses account with description "Ferrari"
    Then BondGoldCard account has a balance of $-800,000
    Then FieldExpenses account has a balance of $0
    Then MI6 bank has pending transfers totaling $800,000
    Then Total money in MI6 bank is $0

  Scenario: Pending outgoing transfer is approved by bank administrator and is applied
    When Bond transfers $50,000 from BondGoldCard account to FieldExpenses account with description "Martinis"
    When M approves transaction "Martinis" with description "Oh James"
    Then BondGoldCard account has a balance of $-50,000
    Then FieldExpenses account has a balance of $50,000
    Then MI6 bank has pending transfers totaling $0
    Then Total money in MI6 bank is $-50000
