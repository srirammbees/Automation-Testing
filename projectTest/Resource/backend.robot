*** Settings ***
Library    MongoDBLibrary
Library    Collections
Library    String
Library    SeleniumLibrary
Resource   ../Resource/project.robot

*** Variables ***

*** Keywords ***

validating data with frontend values inserted
    ${DATA}          retrieve some mongodb records    workflow   projects    {"client":"${CLIENT}","name":"${PROJECT_NAME}","desc":"${DESCRIPTION}"}
    @{DATA_SPLIT}    split string       ${DATA}
    log many    @{DATA_SPLIT}
    ${BACKEND_PROJECT_NAME}    GET FROM LIST    ${DATA_SPLIT}    13
    ${BACKEND_CLIENT_NAME}     GET FROM LIST    ${DATA_SPLIT}    15
    ${BACKEND_GROUP_NAME}      GET FROM LIST    ${DATA_SPLIT}    -3
    should contain          ${BACKEND_PROJECT_NAME}    ${PROJECT_NAME}
    should contain          ${BACKEND_PROJECT_NAME}    ${CLIENT}
    should contain          ${BACKEND_GROUP_NAME}      ${GROUP}

comments data
    ${COMMENTS}     retrieve some mongodb records    workflow    projects    {"client":"${CLIENT}","name":"${PROJECT_NAME}","desc":"${DESCRIPTION}"}
    log     ${COMMENTS}
    @{COMMENT_1}    split string    ${COMMENTS}    comments
    remove from list    ${COMMENT_1}    0
    ${COMMENT_COUNT}    count values in list    ${COMMENT_1}   comment
    log many    @{COMMENT_1}