*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***

${EMAIL_FIELD} =        css=#input-82
${PASSWORD_FIELD} =     css=#input-85
${LOGIN_BUTTON} =       xpath=//*[@id="app"]/div/div/div/main/div/div/div/div/form/div/div[4]/div/button[1]

${PROJECT_TAB_FIELD} =  xpath=//*[@id="app"]/div/div/div/div[2]/div/nav/div[1]/div/div/div[1]
${CREATE_PROJECT} =     xpath=//*[@id="app"]/div/div/div/div[2]/div/nav/div[1]/div/div/div[1]/div[2]/a[1]/div[2]/div


${GROUP_FIELD} =            xpath=//*[@id="input-161"]
${PROJECT_NAME_FIELD} =     xpath=//*[@id="input-166"]
${CLIENT_FIELD} =           xpath=//*[@id="input-169"]
${DESCRIPTION_FIELD} =      xpath=//*[@id="input-175"]
${ORGANISER_FIELD} =        xpath=//*[@id="input-180"]
${ASIGNEE_FIELD} =          xpath=//*[@id="input-186"]
${DUE_BY_FIELD} =           xpath=//*[@id="input-194"]

${CRITICALITY_FIELD} =      xpath=//*[@id="input-198"]
${LINK_BY_FIELD} =          xpath=//*[@id="input-204"]
${ITEMS_FIELD} =            xpath=//*[@id="input-210"]
${CREATE_BUTTON} =          xpath=//*[@id="app"]/div[1]/div/div/main/div/div/div/div[1]/div[1]/div/div[1]/div/div[7]/div/button
${ADD_COMMENT_BUTTON}       xpath=//*[@id="app"]/div/div/div/main/div/div/div/div/div[1]/div[2]/div/div[2]/div/div[2]/div/div/div/button/span/i
${COMMENT_BOX}            xpath=//*[@id="quill-container"]/div[1]
${SAVE_COMMENT_BUTTON}      xpath=//*[@id="app"]/div/div/div/main/div/div/div/div/div[1]/div[2]/div/div[2]/div/div[2]/div/div/div/div/div[2]/button[1]/span/i

@{FIELDS} =    ${PROJECT_NAME_FIELD}    ${CLIENT_FIELD}     ${DESCRIPTION_FIELD}    ${ORGANISER_FIELD}  ${ASIGNEE_FIELD}    ${CRITICALITY_FIELD}    ${LINK_BY_FIELD}    ${ITEMS_FIELD}
@{VALUES} =    ${PROJECT_NAME}  ${CLIENT}   ${DESCRIPTION}  ${ORGANISER}    ${ASIGNEE}  ${CRITICALITY}  ${LINK_BY}


*** Keywords ***
login
    open browser    ${URL}      chrome
    MAXIMIZE BROWSER WINDOW
    input text      ${EMAIL_FIELD}       ${EMAIL}
    input text      ${PASSWORD_FIELD}    ${PASSWORD}
    click button    ${LOGIN_BUTTON}
    sleep    3s
    wait until page contains    Open

creating project
   click element    ${PROJECT_TAB_FIELD}
   sleep  2s
   click element    ${create_project}

   input text       ${group_field}      ${GROUP}
   press keys       ${group_field}      TAB
   press keys       none      TAB

   FOR  ${ITEM1}    IN      @{FIELDS}
        FOR    ${ITEM2}    IN      @{VALUES}
            INPUT TEXT    ${ITEM1}      ${ITEM2}
            PRESS KEYS    ${NONE}      TAB
            remove from list    ${VALUES}   0
            exit for loop
        END
   END

   click element   ${due_by_field}
   sleep  2s
   click element   ${DUE_BY}
   press keys      none      TAB
   ${DUE_DATE} =     get element attribute    xpath=//*[@id="input-194"]     value

    click button    ${create_button}
    sleep    2s

adding comment
    sleep   2s
    #click element    css=#input-424
    sleep            2s
    ${COMMENT_FIELD}    set variable    css=div.v-tab:nth-child(4)
    click element    ${COMMENT_FIELD}
    sleep            2s
    click element     ${ADD_COMMENT_BUTTON}
    sleep            2s
    INPUT TEXT        ${COMMENT_BOX}     ${COMMENT_TEXT}
    click element     ${SAVE_COMMENT_BUTTON}

project update

    ${UPDATE}    set variable    xpath=//*[@id="app"]/div/div/div/div[2]/div/nav/div[1]/div/div/div[1]/div[2]/a[2]
    click element    ${UPDATE}

    ${PROJECT}         set variable    xpath=//*[@id="input-489"]
    ${CLIENT_NAME}     set variable    xpath=//*[@id="input-495"]
    ${PRIORITY}        set variable    xpath=//*[@id="input-513"]
    ${ASIGNEE_C}       set variable    xpath=//*[@id="input-519"]
    ${ORGANISER_C}     set variable    xpath=//*[@id="input-525"]
    ${GROUP_C}         set variable    xpath=//*[@id="input-531"]
    ${SEARCH}          set variable    xpath=//*[@id="app"]/div[1]/div/div/main/div/div/div/div/div/div[1]/div/button

    @{FIELDS}   CREATE LIST      ${PRIORITY}    ${ASIGNEE_C}    ${ORGANISER_C}     ${GROUP_C}   ${SEARCH}
    @{VALUES}   CREATE LIST      ${CRITICALITY}    ${ASIGNEE}   ${ORGANISER}    ${GROUP}


    sleep    10s
    INPUT TEXT       ${PROJECT}     ${PROJECT_NAME}
    sleep   10s
    mouse down       css=div.v-list-item__content:nth-child(1) > div:nth-child(1)
    click element    css=div.v-list-item__content:nth-child(1) > div:nth-child(1)

    INPUT TEXT       ${CLIENT_NAME}     ${CLIENT}
    sleep   10s
    mouse down       css=#list-item-570-0 > div:nth-child(1)
    click element    css=#list-item-570-0 > div:nth-child(1)


    FOR     ${ITEM1}    IN         @{FIELDS}
        FOR     ${ITEM2}     IN     @{VALUES}
                 input text    ${ITEM1}     ${ITEM2}
                 press keys    ${NONE}      TAB
                 remove from list    ${VALUES}    0
                 exit for loop
        END
    END

    CLICK BUTTON    ${SEARCH}

    sleep   5s
    ${data_comment}     set variable    xpath=/html/body/div/div/div/div/main/div/div/div/div/div/div[2]/div/div/div[1]/table/tbody/tr[1]/td[2]/a
    click element       ${data_comment}

    sleep   5s
    scroll element into view    css=th.text-start:nth-child(3) > span:nth-child(1)



