*** Settings ***
Resource    ../../resources/imports.robot
Resource    ../../keywords/common_keywords.robot
Resource    ../../keywords/api/get_order_keywords.robot
Resource    ../../keywords/api/Order_keywords.robot

*** Test Cases ***
GO_01 Success - Post Order success incase pizza crust is NORMAL and Flavor is hawaiian
    [Tags]  regression
    [Documentation]  To mak sure that api can get order correctly
    Given Set Required Parameters To Order Pizza
    And Crust Is NORMAL
    And Flavor Is hawaiian
    And Size Is M
    And Table_No Is ${1}
    And Send Request To Create Order
    Then HTTP Status Should Be '201'

GO_02 Success - Get Order success incase not send any parameter.
    [Tags]  regression
    [Documentation]  To mak sure that api can get order correctly
    Given parameter "Crust" is "NORMAL"
    And parameter "Flavor" is "hawaiian"
    And parameter "Order_ID" is "${EMPTY}"
    And parameter "Size" is "M"
    And parameter "Table_No" is "${1}"
    And parameter "Timestamp" is "${EMPTY}"
    When Send Request To Get Order
    Then HTTP Status Should Be '200'
    And Get Order Return Correctly

GO_03 Success - Delete Order success
    [Tags]  regression
    [Documentation]  Delete Order success
    Given Send Request To delete Order
    And Response Message Should Be 'Order deleted'



