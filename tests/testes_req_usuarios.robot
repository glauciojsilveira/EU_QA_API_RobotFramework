*** Settings ***
Library               RequestsLibrary

Suite Setup    Criar Sessão
Suite Teardown    Deletar Sessão


*** Variables ***



*** Test Cases ***
Teste - CRUD
   
   # CREATE 
   ${USER_ID}  Criação de usuario

   # READ
   Buscar usuario  USER_ID=${USER_ID}

   # UPDATE
   Atualizar dados usuario  USER_ID=${USER_ID}
   Buscar usuario  USER_ID=${USER_ID}     # Mostrar que houve alteração de usuario

   # DELETE
   Deletar usuario  USER_ID=${USER_ID} 



*** Keywords ***
#CRUD
Criação de usuario
   # CABEÇALHO
   ${header}    Create Dictionary    Content-Type=application/json

   # ENVIANDO REQUISIÇÕES
   ${RESPONSE}  POST On Session    alias=api  url=/usuarios  headers=${header}   data={"nome": "Glaucio QA Senior","email": "glauciosilveiraqa@qa001.com.br","password": "teste","administrador": "true"}
   Status Should Be    201    ${RESPONSE}
   Should Be Equal As Strings    Created    ${RESPONSE.reason}
   Should Be Equal As Strings    Cadastro realizado com sucesso    ${RESPONSE.json()['message']}
   ${USER_ID}    Set Variable    ${RESPONSE.json()['_id']}
   Log To Console    ${USER_ID}
   Log To Console    ${RESPONSE.json()['message']}
   RETURN  ${USER_ID}     #Este RETURN habilita todos as outras requisições a usar o USER_ID

Buscar usuario
   [Arguments]    ${USER_ID}
   ${RESPONSE}  GET On Session    alias=api     url=/usuarios/${USER_ID}
   Status Should Be    200    ${RESPONSE}
   ${retorno_get}  Set Variable    ${RESPONSE.json()['_id']}
   Log To Console    ${retorno_get}

Atualizar dados usuario
   [Arguments]  ${USER_ID}
   ${header}    Create Dictionary    Content-Type=application/json

   ${RESPONSE}  PUT On Session    alias=api   url=/usuarios/${USER_ID}   headers=${header}   data={"nome": "Glaucio QA Senior Dois","email": "glaucioa2@qa.com.br","password": "teste","administrador": "true"}
   Status Should Be    200    ${RESPONSE}
   Should Be Equal As Strings    Registro alterado com sucesso    ${RESPONSE.json()['message']}
   ${retorno_put}  Set Variable  ${RESPONSE.json}
   Log To Console  ${retorno_put}

Deletar usuario
   [Arguments]  ${USER_ID}
   ${RESPONSE}  DELETE On Session  alias=api   url=/usuarios/${USER_ID}
   Status Should Be    200    ${RESPONSE}
   Should Be Equal As Strings    Registro excluído com sucesso    ${RESPONSE.json()['message']}  

Criar Sessão
   Create Session  alias=api  url=https://serverest.dev

Deletar Sessão
   Delete All Sessions








