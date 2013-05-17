Feature: Sinatra interface
  So that I can have a json api
  As a user
  I want to use Sinatra to connect with economatic

  Scenario:
    When I go to '/'
    Then I see 'account_balance_enquiry'
    Then I see 'list_accounts'
    Then I see 'update_account'
