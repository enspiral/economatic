Feature:
  In order to pay money to other people in the system
  As an account operator
  I want to be able to transfer money to another account

  Background:
    Given a bank ShireTimebank
    Given account FrodoSavings in ShireTimebank
    Given account BilboChecking in ShireTimebank
    Given a user Gandhalf who can operate FrodoSavings account
    Given FrodoSavings account has an overdraft limit of $-100

  Scenario: Succesfully transfer money
    When Gandhalf transfers $50 from FrodoSavings account to BilboChecking account with description "birthday present"
    Then FrodoSavings account has a balance of $-50
    Then BilboChecking account has a balance of $50
    Then FrodoSavings account has a $50 transfer by Gandhalf to BilboChecking account with description "birthday present" in the transfer log
    Then BilboChecking account has a $50 transfer by Gandhalf from FrodoSavings account with description "birthday present" in the transfer log

  Scenario: Restrict access to accounts
    Given a user Gollum who can not operate FrodoSavings account
    When Gollum transfers $50 from FrodoSavings account to BilboChecking account an error should be raised
    Then FrodoSavings account has a balance of $0
    Then BilboChecking account has a balance of $0

  Scenario Outline: Overdraft limits
    Given FrodoSavings account has an overdraft limit of <overdraft_limit>
    When Gandhalf transfers <transfer_amount> from FrodoSavings account to BilboChecking account <error>
    Then FrodoSavings account has a balance of <frodo_balance>
    Then BilboChecking account has a balance of <bilbo_balance>

    Examples:
    | overdraft_limit | transfer_amount | frodo_balance | bilbo_balance | error                         |
    | $-30            | $50             | $0            | $0            | an error should be raised     |
    | $-30            | $20             | $-20          | $20           | an error should not be raised |

  Scenario: Can't transfer between banks
    Given a bank GondorBuildingSociety
    Given account BoromirSavings in GondorBuildingSociety
    When Gandhalf transfers $50 from FrodoSavings account to BoromirSavings account an error should be raised
