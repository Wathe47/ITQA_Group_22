Feature: Get Book by ID API
  As a library system user
  I want to retrieve book information by ID
  So that I can view specific book details

  Background:
    Given a test book exists in the system
      | id    | title     | author       |
      | 1     | The Forgotten Realm | Lou Kerner |

  Scenario: Successfully retrieve a book with valid ID
    Given I am authenticated as "admin"
    When I send a GET request to "/api/books/1"
    Then the response status code should be 200
    And the response should contain the correct book details

  Scenario: Attempt to retrieve non-existent book
    Given I am authenticated as "admin"
    When I send a GET request to "/api/books/99999"
    Then the response status code should be 404

  Scenario: Attempt to access book without authentication
    Given I am not authenticated
    When I send a GET request to "/api/books/1" without authentication
    Then the response status code should be 401

  Scenario: User role can access book details
    Given I am authenticated as "user"
    When I send a GET request to "/api/books/1"
    Then the response status code should be 200
    And the response should contain the correct book details