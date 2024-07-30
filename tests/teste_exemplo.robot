*** Settings ***
Library               RequestsLibrary

*** Test Cases ***

Quick Get Request Test
    ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
    ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200

Quick Get A JSON Body Test
    ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
    Should Be Equal As Strings    1  ${response.json()}[id]

Teste - CRUD 
    # Criando sessão
    Create Session  alias=api  url=https://serverest.dev
    
    # Cabeçalho
    ${header}  Create Dictionary  Content-Type=application/json

    # Requisiçaõ - Verbo
    POST On Session  alias=api  url=/usuarios  headers=${header}  data={"nome": "Glaucio QA Specialist", "email": "glauciosilveiraqa@gmail.com", "password": "teste", "administrador": "true"}

    # Encerrando a sessão
    Delete All Sessions
