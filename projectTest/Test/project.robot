*** Settings ***
Resource    ../Resource/project.robot
Resource    ../Resource/backend.robot

Library    MongoDBLibrary
Suite Setup       Connect To MongoDB    mongodb+srv://admin:admin@taskapp.bytgp.mongodb.net/
Suite Teardown    Disconnect From MongoDB

*** Variables ***

${URL} =        https://ikarya.metricbees.com/
${EMAIL} =      sanjayrupesh15@gmail.com
${PASSWORD} =   08112000

${GROUP} =          Data
${PROJECT_NAME} =   Testingcomments     #should type in a single word, use camel case for multiple keywords
${CLIENT} =         Test
${DESCRIPTION} =    This is for testing purpose 2
${ORGANISER} =      sanjayrupesh15@gmail.com
${ASIGNEE} =        sanjayrupesh15@gmail.com
${DUE_BY} =         xpath=//*[@id="app"]/div[8]/div/div/div/div[2]/table/tbody/tr[5]/td[6]/button/div
${DUE_DATE}
${CRITICALITY} =    High
${LINK_BY} =        should start after
${ITEMS} =          test
${COMMENT_TEXT} =   comments

*** Test Cases ***

open browser and login
    [Tags]    Login
    project.login

creating project
    project.creating project

database data
    [Tags]    Backend
    backend.validating data with frontend values inserted

commenting
    project.adding comment
    #project.project update

*** Keywords ***

# robot -d Result Test\project.robot