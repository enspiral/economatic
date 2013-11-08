Feature: Play information
  In order to understand what api calls I can make
  As a front end developer
  I want to get information about the plays

  Background:
    Given sinatra includes a play called 'economatic'

  Scenario:
    When I go to '/plays'
    Then I see 'economatic'