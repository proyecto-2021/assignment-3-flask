*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***

# POSTs
Create assignment
    [Arguments]     ${id}   ${name}     ${descr}  ${price}    ${status}
    ${data}=    Create dictionary   id=${${id}}    name=${name}    description=${descr}  price=${${price}}  status=${status}
    ${resp}=    POST On Session  assignment3    /assignments   json=${data}     expected_status=any
    [Return]    ${resp}


# PUTs
Update assignment
    [Arguments]     ${id}   ${name}
    ${data}=    Create dictionary   name=${name}
    ${resp}=    PUT On Session  assignment3    /assignments/${id}   json=${data}   expected_status=any
    [Return]    ${resp}


# GETs
Get all assignments
    ${resp}=    GET On Session  assignment3    /assignments
    [Return]    ${resp}

Get list of assignments
    ${resp}=    GET On Session  assignment3    /assignments
    ${list_assign}=     Get From Dictionary    ${resp.json()}    assignments
    [Return]    ${list_assign}

Get by id
    [Arguments]     ${id}
    ${resp}=    GET On Session  assignment3    /assignments/${id}       expected_status=any
    [Return]    ${resp}


# DELETEs
Delete assignment
    [Arguments]     ${id}
    ${resp}=    DELETE On Session  assignment3    /assignments/${id}    expected_status=any
    [Return]    ${resp}

Delete assignment if exists
    [Arguments]     ${id}
    ${resp}=    Get by id    ${id}
    IF    ${resp.status_code} == 200
        Delete assignment    ${id}
    END
    [Return]    ${resp}