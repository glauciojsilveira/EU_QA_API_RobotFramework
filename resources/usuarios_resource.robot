*** Settings ***
Library               RequestsLibrary

*** Variables ***

*** Keywords ***
#CRUD
Criação de usuario
   # CABEÇALHO
   ${header}    Create Dictionary    Content-Type=application/json

   # ENVIANDO REQUISIÇÃO - COM MAIS DE UMA OPÇÃO DE VERIFICAÇÃO QUE PODE SER USADA PARA VALIDAÇÃO
   ${RESPONSE}  POST On Session    alias=api  url=/usuarios  headers=${header}   data={"nome": "Glaucio QA Senior","email": "glauciojs@q2024.com.br","password": "teste","administrador": "true"}   
   ...     expected_status=201
   Status Should Be    201    ${RESPONSE}
   Should Be Equal As Strings    Created    ${RESPONSE.reason}
   Should Be Equal As Strings    Cadastro realizado com sucesso    ${RESPONSE.json()['message']}
   ${USER_ID}    Set Variable    ${RESPONSE.json()['_id']}
   Log To Console    ${USER_ID}
   Log To Console    ${RESPONSE.json()['message']}
   RETURN  ${USER_ID}     #Este RETURN habilita todos as outras requisições a usar o USER_ID

Buscar usuario
   [Arguments]    ${USER_ID}
   ${RESPONSE}  GET On Session    alias=api     url=/usuarios/${USER_ID}     expected_status=200
   Status Should Be    200    ${RESPONSE}

Buscar usuario após update
   [Arguments]    ${USER_ID}
   ${RESPONSE}  GET On Session    alias=api     url=/usuarios/${USER_ID}     expected_status=200
   Status Should Be    200    ${RESPONSE}
   ${retorno_get}  Set Variable    ${RESPONSE.json()}

   ${EMAIL}  Set Variable  ${RESPONSE.json()['email']}
   Should Be Equal    ${EMAIL}   glauciojsilveira@qa002024.com.br
   
   Log To Console     ${retorno_get}

Atualizar dados usuario
   [Arguments]  ${USER_ID}
   ${header}    Create Dictionary    Content-Type=application/json

   ${RESPONSE}  PUT On Session    alias=api   url=/usuarios/${USER_ID}   headers=${header}   data={"nome": "Glaucio QA Senior Dois","email": "glauciojsilveira@qa002024.com.br","password": "teste","administrador": "true"}  
   ...    expected_status=200  
   Status Should Be    200    ${RESPONSE}
   Should Be Equal As Strings    Registro alterado com sucesso    ${RESPONSE.json()['message']}
   ${retorno_put}  Set Variable  ${RESPONSE.json}
   
   Log To Console  ${retorno_put}

Deletar usuario
   [Arguments]  ${USER_ID}
   ${RESPONSE}  DELETE On Session  alias=api   url=/usuarios/${USER_ID}    expected_status=200
   Status Should Be    200    ${RESPONSE}
   Should Be Equal As Strings    Registro excluído com sucesso    ${RESPONSE.json()['message']} 

Validar que usuario não existe
   [Arguments]    ${USER_ID}
   ${RESPONSE}  GET On Session    alias=api     url=/usuarios/${USER_ID}     expected_status=400
   Status Should Be    400    ${RESPONSE}
   Should Be Equal As Strings    Usuário não encontrado    ${RESPONSE.json()['message']}

Criar Sessão
   Create Session  alias=api  url=https://serverest.dev

Deletar Sessão
   Delete All Sessions








