*** Settings ***
Library  SeleniumLibrary

*** Keywords ***

Begin Web Test
    Open Browser  about:blank  safari

End Web Test
    Close Browser