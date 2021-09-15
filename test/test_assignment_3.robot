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
    And An assignment with id 10, name "New Task", description "To do something", price 100 and status "todo" should exist
    And The number of assignments in the system should be "N+1"

Scenario: Try to create an existing assignment
    Given An assignment with id 11, name "Another Task", description "To do something else", price 1000 and status "Another todo" exists in the system
    And The number of assignments in the system is "N"
    When We create an assignment with id 11, name "Yet Another Task", description "To do something", price 2000 and status "Yet another todo"
    Then Server response should have status code 409
    And An assignment with id 11, name "Another Task", description "To do something else", price 1000 and status "Another todo" should exist
    And The number of assignments in the system should be "N"

Scenario: Delete an existing assignment
    Given An assignment with id 12, name "Delete Task", description "To be deleted", price 2000 and status "Delete todo" exists in the system
    And The number of assignments in the system is "N"
    When We delete the assignment with id 12
    Then Server response should have status code 200
    And The number of assignments in the system should be "N-1"

Scenario: Try to delete a non existing assignment
    Given An assignment with id 12 does not exist in the system
    And The number of assignments in the system is "N"
    When We delete the assignment with id 12
    Then Server response should have status code 404
    And The number of assignments in the system should be "N"

