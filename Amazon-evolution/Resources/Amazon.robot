*** Settings ***
Documentation    This is some basic info about the whole suite
Library  SeleniumLibrary


*** Keywords ***

Search for Products
    Go To  http://www.amazon.com
    Input Text  id=twotabsearchtextbox  Samsung A71
    click Button  xpath=//*[@id="nav-search-submit-button"]
    wait until page contains  results for "Samsung A71"

Select Product from Search Results
    click link  css=#search > div.s-desktop-width-max.s-desktop-content.sg-row > div.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16 > div > span:nth-child(4) > div.s-main-slot.s-result-list.s-search-results.sg-row > div:nth-child(2) > div > span > div > div > div:nth-child(2) > div.sg-col-4-of-12.sg-col-8-of-16.sg-col-12-of-20.sg-col > div > div:nth-child(1) > div > div > div:nth-child(1) > h2 > a


