*** Settings ***
Resource          ../../resources/imports.robot

*** Keywords ***
Get Order Return Correctly
    ${json_response}    JSONLibrary.Convert String To JSON    ${response.text}
    Set Test Variable    ${json_response}    ${json_response}
    log    ${json_response}

    ${response}=    Set Variable    ${json_response}
    set test variable    ${response}    ${response}
    ${length}=    Get Length    ${response}

    :FOR    ${index}    IN RANGE    0    ${length}
    \    Log    ${index}
    \    ${response_order}=    Get From List    ${response}    ${index}
    \    Log      ${response_order}
    \    set test variable    ${index}    ${index}
    \    set test variable    ${response_order}    ${response_order}
    \    run keyword if    '${response_order['Crust']}'=='NORMAL' and '${response_order['Flavor']}'=='BEEF-NORMAL'    NORMAL and BEEF-NORMAL Order Detail Should Display
    \    run keyword if    '${response_order['Crust']}'=='THIN' and '${response_order['Flavor']}'=='CHEESE'    THIN and CHEESE Order Detail Should Display
    \    run keyword if    '${response_order['Crust']}'=='NORMAL' and '${response_order['Flavor']}'=='CHICKEN-FAJITA'    NORMAL and CHICKEN-FAJITA Order Detail Should Display

NORMAL and CHICKEN-FAJITA Order Detail Should Display
    should be equal as strings    ${response_order['Crust']}    NORMAL
    should be equal as strings    ${response_order['Flavor']}    CHICKEN-FAJITA
    should be equal as strings    ${response_order['Order_ID']}    3
    should be equal as strings    ${response_order['Size']}    L
    should be equal as strings    ${response_order['Table_No']}    3
    should be equal as strings    ${response_order['Timestamp']}    2019-12-03T18:21:08.710006

THIN and CHEESE Order Detail Should Display
    should be equal as strings    ${response_order['Crust']}    THIN
    should be equal as strings    ${response_order['Flavor']}    CHEESE
    should be equal as strings    ${response_order['Order_ID']}    2
    should be equal as strings    ${response_order['Size']}    S
    should be equal as strings    ${response_order['Table_No']}    5
    should be equal as strings    ${response_order['Timestamp']}    2019-12-03T18:21:08.708470

NORMAL and BEEF-NORMAL Order Detail Should Display
    should be equal as strings    ${response_order['Crust']}    NORMAL
    should be equal as strings    ${response_order['Flavor']}    BEEF-NORMAL
    should be equal as strings    ${response_order['Order_ID']}    1
    should be equal as strings    ${response_order['Size']}    M
    should be equal as strings    ${response_order['Table_No']}    1
    should be equal as strings    ${response_order['Timestamp']}    2019-12-03T18:21:08.669365


