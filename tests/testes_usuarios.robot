*** Settings ***
Library               RequestsLibrary
Resource   ../resources/usuarios_resource.robot

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
   Buscar usuario após update  USER_ID=${USER_ID}    # Mostra se houve alterações
   # DELETE
   Deletar usuario  USER_ID=${USER_ID} 

   Validar que usuario não existe  USER_ID=${USER_ID} 





