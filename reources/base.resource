*** Settings ***
Documentation        Tudo começa aqui

Library              SeleniumLibrary

Resource             pages/SignupPage.robot

*** Variables ***
${BASE_URL}         https://walkdog.vercel.app/signup
${BROWSER}          Chrome
${DELAY}            2s  

*** Keywords ***
Start Session
    Open Browser    ${BASE_URL}  ${BROWSER}


Finish Session
    Capture Page Screenshot
    Close Browser
