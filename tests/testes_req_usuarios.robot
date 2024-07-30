*** Settings ***
Library               RequestsLibrary

*** Variables ***



*** Test Cases ***
Teste - CRUD 
   # CRIAR
   Create Session  alias=api  url=https://serverest.dev

   Criação de usuario

   Buscar usuario
   
   
   # ATUALIZAR
   ${RESPONSE}  PUT On Session    alias=api   url=/usuarios/${USER_ID}   headers=${header}   data={"nome": "Glaucio QA Senior Dois","email": "glaucioa2@qa.com.br","password": "teste","administrador": "true"}
   ${retorno_put}  Set Variable  ${RESPONSE.json}
   Log To Console  ${retorno_put}

# LER Atualização

   # DELETAR
   DELETE On Session  alias=api   url=/usuarios/${USER_ID}   

   # CRIAR SESSÃO

   # ENCERRAR
   Delete All Sessions

*** Keywords ***

Criação de usuario
   # CABEÇALHO
   ${header}    Create Dictionary    Content-Type=application/json

   # ENVIANDO REQUISIÇÕES
   ${RESPONSE}  POST On Session    alias=api  url=/usuarios  headers=${header}   data={"nome": "Glaucio QA Senior","email": "glauciosilveiraqa@qa.com.br","password": "teste","administrador": "true"}
   ${USER_ID}    Set Variable    ${RESPONSE.json()['_id']}
   Log To Console    ${USER_ID}
   
   RETURN  ${USER_ID}    #Este RETURN habilita todos as outras requisições a usar o USER_ID


Buscar usuario
   [Arguments]    ${USER_ID}
   ${RESPONSE}  GET On Session    alias=api     url=/usuarios/${USER_ID}
   ${retorno_get}  Set Variable    ${RESPONSE.json()['_id']}
   Log To Console    ${retorno_get}

Atualizar dados usuario

Deletar usuario

Criar Sessão

Deletar Sessão







