*** Settings ***
Documentation            Arquivo que representa a página de cadastro com ações e elementos

Library                SeleniumLibrary

*** Keywords ***
Fill signup form
    [Arguments]        ${name}=Tony Stark  ${email}=Tony@Stark.com  ${cpf}=84523566097  ${cep}=04836-411    ${addressStreet}=Rua Oceano Atlântico  ${addressNumber}=228  ${addressDetails}=A  ${addressDistrict}=Vila Albertina  ${addressCityUf}=São Paulo/SP
    
    Wait Until Element Is Visible    css=input[name='name']

    Input Text         css=input[name='name']              ${name}
    Input Text         css=input[name="email"]             ${email}
    Input Text         css=input[name="cpf"]               ${cpf}
    Input Text         css=input[name="cep"]               ${cep}
    Click Button       css=input[type='button']
    Input Text         css=input[name="addressNumber"]    ${addressNumber}
    Input Text         css=input[name="addressDetails"]   ${addressDetails}
   
   # Click Element       css=input[type='file']

Submit signup form
     Click Element       xpath=//button[contains(text(), "Cadastrar")]
  



Popup have text
    [Arguments]    ${expected_text}

    ${element}    Set Variable      css=div.swal2-icon-success

    Element Should Be Visible       ${element}     
    Element Should Contain          ${element}     ${expected_text}

Alert have text
    [Arguments]    ${expected_text}

    ${element}    Set Variable     xpath=//span[@class="alert-error"][text()="${expected_text}"]         
   
    Element Should Be Visible     ${element}  
    Capture Element Screenshot    ${element}  