@wip
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
    Given BondGoldCard account has an overdraft limit of $-100
    Given a user M who can administer MI6 bank
    Given a user Bond who can operate BondGoldCard account

  Scenario: Transfer money in from external account
    When M transfers $10,000,000 from PublicGrants account to Operations account with description "Budget for 1967"
    Then Total money in bank is $10,000,000
    Then PublicGrants has a balance of $-10,000,000
    Then Operations has a balance of $10,000,000

  Scenario: Transfer money out to external account and it is held as pending
    When Bond transfers $800,000 from BondGoldCard account to FieldExpenses account with description "Ferrari"
    Then FieldExpenses has a balance of $0
    Then BondGoldCard has a balance of $-800,000
    Then MI6 has pending transactions totaling $800,000

  Scenario: Pending outgoing transaction is approved by bank administrator and is applied
    Given Total money in bank is $0
    Given MI6 has a pending transaction from BondGoldCard account to FieldExpenses account for $50,000 with description "Martinis"
    When M approves transaction "Martinis" with description "Oh James"
    Then BondGoldCard has a balance of $-50,000
    Then Total money in bank is $-50000
    Then MI6 has pending transactions totaling $0
    Then FieldExpenses has a balance of $50,000
