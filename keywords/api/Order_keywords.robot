*** Settings ***
Resource          ../../resources/imports.robot

*** Keywords ***
Set Required Parameters To Order Pizza
    ${data}=    Create Dictionary
    Set To Dictionary    ${data}    Crust=${Empty}
    Set To Dictionary    ${data}    Flavor=${Empty}
    Set To Dictionary    ${data}    Size=${Empty}
    Set To Dictionary    ${data}    Table_No=${Empty}
    Set Test Variable    ${data}    ${data}
