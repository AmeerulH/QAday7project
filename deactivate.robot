*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary

*** Variable ***
${email_field}  name=email
${deactivateText}       //*[contains(@class, "dc-text deactivate-account__information--bold")]
${1}     //*[@class="deactivate-account__steps"]//*[text()="1. Ensure to close all your positions"]
${2}     //*[@class="deactivate-account__steps"]//*[text()="2. Withdraw your funds"]

*** Test Cases ***
Open ApiToken
    Open Page
    DeactivatePage

*** Keywords ***
Open Page
    open browser    https://app.deriv.com/account/deactivate-account     chrome
    set window size     1280    1028
    wait until page contains element    txtEmail   10
    input text      ${email_field}      ${my_email}
    input password      txtPass     ${my_pw}
    click button    login

DeactivatePage
    wait until page contains element    ${deactivateText}
    element text should be      ${deactivateText}   Deactivate account
    element text should be      ${1}    1. Ensure to close all your positions
    element text should be      ${2}    2. Withdraw your funds