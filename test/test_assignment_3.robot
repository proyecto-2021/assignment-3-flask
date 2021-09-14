*** Settings ***
Resource    assignment3_high_level_keywords.robot

Suite Setup     Start server and create new session
Suite Teardown  Shutdown server

*** Test Cases ***
Scenario: Create a new assignment
    Given An assignment with id 10 does not exist in the system
    And The number of assignments in the system is "N"
    When We create an assignment with id 10, name "New Task", description "To do something", price 100 and status "todo"
    Then Server response should have status code 200
    And An assignment with id 10, name "New Task", description "To do something", price 100 and status "todo" should be created
    And The number of assignments in the system should be "N+1"
