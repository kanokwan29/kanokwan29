*** Settings ***
Resource        ../resources/imports.robot

*** Keywords ***

HTTP Status Should Be '${code}'
    log    ${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    ${code}

parameter "${parameter}" is "${value}"
    ${is_variable_exist}    Run Keyword And Return Status    Variable Should Exist    ${interested_parameters}
    Run Keyword if    '${is_variable_exist}'=='False'    Create Test Dic
    Set To Dictionary    ${interested_parameters}    ${parameter}=${value}
    Set Test Variable    ${${parameter}}    ${value}
    log    ${value}

create Test Dic
    ${interested_parameters}    Create Dictionary
    Set Test Variable    ${interested_parameters}

Crust Is ${Crust_value}
    Set To Dictionary    ${data}    Crust=${Crust_value}
    Set Test Variable    ${Crust_value}    ${Crust_value}
    log    ${Crust_value}

Flavor Is ${Flavor_value}
    Set To Dictionary    ${data}    Flavor=${Flavor_value}
    Set Test Variable    ${Flavor_value}    ${Flavor_value}
    log    ${Flavor_value}

Size Is ${Size_value}
    Set To Dictionary    ${data}    Size=${Size_value}
    Set Test Variable    ${Size_value}    ${Size_value}
    log    ${Size_value}

Table_No Is ${Table_No_value}
    Set To Dictionary    ${data}    Table_No=${Table_No_value}
    Set Test Variable    ${Table_No_value}    ${Table_No_value}
    log    ${Table_No_value}

Set Required Parameters To Order Pizza Test
    ${req_body}=    Create Dictionary    Crust=${Empty}
    Set To Dictionary    ${req_body}    Flavor=${Empty}
    Set To Dictionary    ${req_body}    Size=${Empty}
    Set To Dictionary    ${req_body}    Table_No=${4}
    Set Test Variable    ${req_body}    ${req_body}

Send Request To Create Order
     log    ${data}
     Create Token
     ${headers}=    Create Dictionary    Content-Type=application/json
     set to dictionary    ${headers}    Authorization=Bearer ${auth}
     Create Session    Create_Order    ${Order_host}    headers=${headers}    disable_warnings=1
     ${response}=    Post Request    Create_Order    ${create_order_url}    data=${data}
     log    ${response}
     ${json_response}    To Json    ${response.text}
     Set Test Variable    ${response}    ${response}
     Set Test Variable    ${json_response}    ${json_response}

Create Token
    ${Token_data}=    Create Dictionary
    Set To Dictionary    ${Token_data}    password=test
    Set To Dictionary    ${Token_data}    username=test
    Set Test Variable    ${Token_data}    ${Token_data}

    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    Create_Token    ${Token_host}    headers=${headers}    disable_warnings=1
    ${response}=    Post Request    Create_Token    auth    data=${Token_data}
    ${Token_response}    To Json    ${response.text}
    Set Test Variable    ${response}    ${response}
    Set Test Variable    ${Token_response}    ${Token_response}

    should not be empty    ${Token_response['access_token']}
    Set Test Variable   ${auth}     ${Token_response['access_token']}
    [Return]  ${auth}

Response Message Should Be '${msg}'
    Should Be Equal As Strings    ${json_response['message']}    ${msg}

Send Request To delete Order
    Create Session    delete_order    ${Order_host}    disable_warnings=1
	${response}=    Delete Request    delete_order    orders/${1}
	${json_response}    JSONLibrary.Convert String To JSON    ${response.text}
    Set Test Variable    ${json_response}    ${json_response}
    log    ${json_response}

Send Request To Get Order
    log  ${interested_parameters}
    Create Session    order    ${Order_host}    disable_warnings=1
	${response}=    Get Request    order    ${create_order_url}    params=${interested_parameters}
	Set Test Variable    ${response}    ${response}
	Log    ${response.text}



