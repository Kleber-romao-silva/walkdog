*** Settings ***

Resource          ${EXECDIR}/reources/base.resource

Test Setup        Start Session
Test Teardown     Finish Session

*** Variables ***
${DOCUMENT}       ${EXECDIR}/fixtures/habilitacao.jpg

*** Test Cases ***
Cenário: Cadastro de Dog Walker com Sucesso
    [Documentation]  Testa o cadastro de Dog Walker com sucesso.

    Quando Submeto o Formulário de Cadastro com Meus Dados Pessoais
    E Submeto o Documento de Identificação
    E Clico no Botão "Cadastrar"
    Então Devo Ver uma Mensagem de Sucesso Informando que Meu Cadastro Foi para Análise

Cenário: CPF Incorreto
    [Documentation]  Testa o preenchimento de um CPF incorreto.

    Quando Submeto o Formulário Informando um CPF Incorreto
    E Clico no Botão "Cadastrar"
    Então Devo Ver uma Mensagem de Alerta com o Seguinte Texto: "CPF inválido"

Cenário: Email Incorreto
    [Documentation]  Testa o preenchimento de um email incorreto.

    Quando Submeto o Formulário Informando um Email Incorreto
    E Clico no Botão "Cadastrar"
    Então Devo Ver uma Mensagem de Alerta com o Seguinte Texto: "Informe um email válido"

Cenário: Campos Obrigatórios
    [Documentation]  Testa o envio do formulário sem preencher campos obrigatórios.

    Quando Submeto o Formulário Sem Preencher Nenhum dos Campos
    E Clico no Botão "Cadastrar"
    Então Devo Ver uma Mensagem de Alerta Avisando que Esses Campos São Obrigatórios

*** Keywords ***
Quando Submeto o Formulário de Cadastro com Meus Dados Pessoais
    [Documentation]    Cadastro de Dog Walkers com sucesso
    [Tags]             happy_path
    
    Fill signup form
   
E Submeto o Documento de Identificação
    Choose File         css=input[type='file']    ${DOCUMENT}
  
E Clico no Botão "Cadastrar"

   Submit signup form

Então Devo Ver uma Mensagem de Sucesso Informando que Meu Cadastro Foi para Análise
    Sleep    2
    Popup have text     Recebemos o seu cadastro
   
Quando Submeto o Formulário Informando um CPF Incorreto
    [Arguments]         ${CPF_INV}=8452356600A

    Input Text          css=input[name='cpf'][type='text']      ${CPF_INV} 
    Click Element       xpath=//button[contains(text(), "Cadastrar")]
   

Então Devo Ver uma Mensagem de Alerta com o Seguinte Texto: "CPF inválido"
    
    Alert have text    CPF inválido
    
Quando Submeto o Formulário Informando um Email Incorreto
    [Arguments]    ${EMAIL_INV}=TONYSTARK.COM

    Input Text  css=input[name="email"]  |${EMAIL_INV}
   
Então Devo Ver uma Mensagem de Alerta com o Seguinte Texto: "Informe um email válido"
   
    Alert have text     Informe um email válido
   
Quando Submeto o Formulário Sem Preencher Nenhum dos Campos
   
    Input Text    css=input[name="name"]             ${EMPTY}
    Input Text    css=input[name="email"]            ${EMPTY}
    Input Text    css=input[name="cpf"]              ${EMPTY}
    Input Text    css=input[name="cep"]              ${EMPTY}
    Input Text    css=input[name="addressNumber"]    ${EMPTY}
    
    E Clico no Botão "Cadastrar"
   

Então Devo Ver uma Mensagem de Alerta Avisando que Esses Campos São Obrigatórios
    [Tags]    required

    Wait Until Page Contains  Informe o cep, número e complemento
   
    Element Should Be Visible      //span[@class='alert-error'][contains(.,'Informe o seu nome completo')]
    Capture Element Screenshot     //span[@class='alert-error'][contains(.,'Informe o seu nome completo')]
    Wait Until Element Is Visible    //span[@class='alert-error'][contains(.,'Informe o seu melhor email')] 
    Capture Element Screenshot      //span[@class='alert-error'][contains(.,'Informe o seu melhor email')]
    Wait Until Element Is Visible    //span[@class='alert-error'][contains(.,'Informe o seu CPF')]
    Capture Element Screenshot      //span[@class='alert-error'][contains(.,'Informe o seu CPF')]
    Wait Until Element Is Visible    //span[@class="alert-error"][text()="Informe um número maior que zero"]
    Capture Element Screenshot      //span[@class="alert-error"][text()="Informe um número maior que zero"]
   
   # Wait Until Element Is Visible    //span[@class="alert-error"][text()="Adicione um documento com foto (RG ou CNH)"]
   # Capture Element Screenshot      //span[@class="alert-error"][text()="Adicione um documento com foto (RG ou CNH)"]
   
   