*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Library     Process

Resource    assignment3_low_level_keywords.robot

*** Variables ***
${max_iterations}   200
${sleep_time}       1
${URL}              http://127.0.0.1:4000


*** Keywords ***
Start server and create new session
    Start server
    Create new session

Create new session
    Create Session  assignment3  ${URL}

# Server init and shutdown
Start server
    Start Process     bash    run.sh  shell=True
    Set Local Variable    ${status}   FAIL
    FOR    ${i}    IN RANGE   ${max_iterations}
        Run  sleep ${sleep_time}
        ${status}  ${response}    Run Keyword And Ignore Error    GET   ${URL}/assignments
        IF  "${status}" == "PASS"
            IF  ${response.status_code} == 200
                Set Local Variable    ${status}   OK
                Exit For Loop
            END
        END
    END
    IF  "${status}" != "OK"
        Fail
    END

Shutdown server
    ${resp}=    POST On Session  assignment3    /shutdown
    [Return]    ${resp}



An assignment with id ${id} does not exist in the system
    No Operation


The number of assignments in the system is "N"
    ${list}=    Get list of assignments
    ${num_items}=   Get length  ${list}
    Set test variable  ${prev_num_items}     ${num_items}


We create an assignment with id ${id}, name "${name}", description "${descr}", price ${price} and status "${status}"
    ${resp}=    Create assignment     ${id}   ${name}     ${descr}    ${price}    ${status}
    Set test variable  ${post_resp}     ${resp}


An assignment with id ${id}, name "${name}", description "${descr}", price ${price} and status "${status}" should be created
    ${resp}=    Get by id   ${id}
    Status Should Be    200     ${resp}
    ${assignments}=      Get From Dictionary    ${resp.json()}    assignment
    ${assignment}=      Get From List   ${assignments}   0
    Dictionary Should Contain Item    ${assignment}    id    ${id}
    Dictionary Should Contain Item    ${assignment}    name    ${name}
    Dictionary Should Contain Item    ${assignment}    description    ${descr}
    Dictionary Should Contain Item    ${assignment}    price    ${price}
    Dictionary Should Contain Item    ${assignment}    status    ${status}


The creation operation should be successful
    Status Should Be    200     ${post_resp}


The number of assignments in the system should be "N+1"
    ${list}=    Get list of assignments
    ${num_items}=   Get length  ${list}
    Should be equal as integers     ${${prev_num_items}+1}    ${num_items}