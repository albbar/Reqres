Feature: Test API Reqres
  I want to use this template for my feature file
  
  Background:
  * url baseURL
  * header Accept = 'application/json'
  
  @ListUsers
  Scenario Outline: the user is not on the list
    Given path '/users?page=2'
    When method Get
    Then status <status>
    And match $..first_name !contains <name>
    And print response

    Examples: 
      | name    | status |
      | "Alberto" | 200 |

   @CrerateUser
   Scenario Outline:Create User
     Given path '/users'
     And request {"name": <name>, "job": <job>}
     When method POST
     Then status <status>
     And match response == {"createdAt": "#ignore",	"name": <name>, "id": "#string",	"job": <job>}
     And print response

     Examples: 
       | name    | job | status |
       | Alberto | QA | 201 |
       
       
   @UserExist
   Scenario Outline: the user is on the list
    Given path '/users/2'
    When method Get
    Then status <status>
    And match $..first_name contains <name>
    And print response

    Examples: 
      | name    | status |
      | "Alberto" | 200 |
      | "Janet" | 200 |
      
              
           
   @UserNotExist
   Scenario Outline: the user is not on the list
    Given path '/users/2'
    When method Get
    Then status <status>
    And match $..first_name !contains <name>
    And print response

    Examples: 
      | name    | status |
      | "Alberto" | 200 |
       
       