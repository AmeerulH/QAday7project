*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary

*** Variable ***
${email_field}  name=email
${read}     //*[@class="composite-checkbox api-token__checkbox"]//*[text()="Read"]
${trade}    //*[@class="composite-checkbox api-token__checkbox"]//*[text()="Trade"]
${admin}    //*[@class="composite-checkbox api-token__checkbox"]//*[text()="Admin"]
${payments}    //*[@class="composite-checkbox api-token__checkbox"]//*[text()="Payments"]
${tradingInformation}    //*[@class="composite-checkbox api-token__checkbox"]//*[text()="Trading information"]
${apiLoading}   //*[contains(@class, "initial-loader account__initial-loader")]
${tradeSelected}    //*[@class="composite-checkbox api-token__checkbox composite-checkbox--active"]//*[text()="Trade"]
${readSelected}    //*[@class="composite-checkbox api-token__checkbox composite-checkbox--active"]//*[text()="Read"]
${adminSelected}    //*[@class="composite-checkbox api-token__checkbox composite-checkbox--active"]//*[text()="Admin"]
${checkRead}    //*[contains(@class, "dc-checkbox__input") and @name="read"]
${checkTrade}    //*[contains(@class, "dc-checkbox__input") and @name="trade"]
${checkAdmin}    //*[contains(@class, "dc-checkbox__input") and @name="admin"]
${tokenName}    //*[contains(@name, "token_name")]
${createButton}     //button[contains(@class, "dc-btn dc-btn__effect dc-btn--primary dc-btn__large da-api-token__button")]
${testName}     //*[@class="da-api-token__table-cell-row"]//*[text()="test"]
${testScope}     //*[@class="da-api-token__table-cell-row"]//*[text()="Read, Admin"]
${row}      //*[@class="da-api-token__table-cell-row"]
${copyButton}   //*[@class="dc-icon dc-clipboard da-api-token__clipboard"]
${delete}   //button[.//span='Delete']
${btnGroup}     //*[contains(@class, "dc-btn__group")]
${noButton}     //button[.//span='No']
${yesButton}     //button[.//span='Yes']
${All}     //*[@class="da-api-token__table-cell-row"]//*[text()="All"]
#${noButton}     //*[@id="app_contents"]/div/div/div/div/div[2]/div/div[2]/div/section/div/div/form/div/div[3]/div[2]/div/div/table/tbody/tr[1]/td[5]/div/button[1]
#${yesButton}    //*[@id="app_contents"]/div/div/div/div/div[2]/div/div[2]/div/section/div/div/form/div/div[3]/div[2]/div/div/table/tbody/tr[1]/td[5]/div/button[2]

*** Test Cases ***
Open ApiToken
    open browser    https://app.deriv.com/account/api-token     chrome
    set window size     1280    1028
    wait until page contains element    txtEmail   10
    input text      ${email_field}      ${my_email}
    input password      txtPass     ${my_pw}
    click button    login
    wait until page does not contain element    ${apiLoading}   10
    wait until page contains element  ${read}     10
    click element   ${read}
    click element   ${admin}
    click element   ${trade}
    click element   ${tradeSelected}
    element attribute value should be    ${checkRead}   value    true
    element attribute value should be    ${checkAdmin}   value    true
    element attribute value should be    ${checkTrade}   value    false
    click element   ${readSelected}
    click element   ${adminSelected}
    input text  ${tokenName}    test
    element should be disabled      ${createButton}
    click element   ${read}
    click element   ${admin}
    wait until element is enabled   ${createButton}
    element should be enabled       ${createButton}
    click button    ${createButton}
    element should be disabled      ${createButton}
    wait until page contains element    ${row}
#    element text should be  ${testName}     test
    element text should be  ${testScope}    Read, Admin
    click element   ${copyButton}
    Press Key       ${tokenName}       \\22
    ${current_value}=   get element attribute   ${tokenName}  value
    ${value_length}=    get length  ${current_value}
    element text should be  ${tokenName}    ${current_value}
    Repeat Keyword     ${value_length}     press keys      ${tokenName}      BACKSPACE
    Repeat Keyword     1    press keys     ${tokenName}      DELETE
    click button    ${delete}
    wait until page contains element  ${btnGroup}     10
    page should contain element      ${noButton}
    page should contain element      ${yesButton}
#    wait until page contains element    ${noButton}
    click element   ${noButton}
    wait until page contains element    ${delete}
    click element   ${delete}
    wait until page contains element    ${btnGroup}
    click element   ${yesButton}
    wait until page does not contain element    ${row}
    page should not contain element     ${row}
    click element   ${read}
    click element   ${admin}
    click element   ${trade}
    click element   ${payments}
    click element   ${tradingInformation}
    input text  ${tokenName}    All
    wait until element is enabled   ${createButton}
    click button    ${createButton}
    wait until page contains element    ${row}
    element text should be  ${All}    All
    wait until page contains element    ${delete}
    click element   ${delete}
    wait until page contains element    ${btnGroup}
    click element   ${yesButton}

*** Keywords ***
Provided precondition
    Setup system under test