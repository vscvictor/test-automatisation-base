@REQ_MARVEL-002 @HU002 @character_flow @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: MARVEL-002 Flujos de operaciones con personajes (microservicio para probar flujos completos de personajes Marvel)

  Background:
    * url port_marvel_characters_api
    * path '/characters'
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @flujoCompleto @creacionYConsulta
  Scenario: T-API-MARVEL-002-CA01-Crear y consultar personaje - karate
    # Crear personaje
    * def jsonData = read('classpath:data/marvel_characters_api/character_create_2.json')
    * def randomName = 'I2_' + java.util.UUID.randomUUID()
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id

    # Consultar personaje creado
    * path 'characters/' + personajeId
    When method GET
    Then status 200
    # And match response.name == 'Captain America'
    # And match response.alterego == 'Steve Rogers'

  @id:2 @flujoCompleto @creacionActualizacionYEliminacion
  Scenario: T-API-MARVEL-002-CA02-Crear, actualizar y eliminar personaje - karate
    # Crear personaje
    * def jsonData = read('classpath:data/marvel_characters_api/character_create_2.json')
    * def randomName = 'I2_' + java.util.UUID.randomUUID()
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    * def personajeId = response.id
    
    # Actualizar personaje
    * path 'characters/' + personajeId
    * def jsonDataUpdate = read('classpath:data/marvel_characters_api/character_update.json')
    * set jsonDataUpdate.name = 'Captain America'
    And request jsonDataUpdate
    When method PUT
    Then status 200
    # And match response.description == 'Updated description'
    
    # Eliminar personaje
    * path 'characters/' + personajeId
    When method DELETE
    Then status 204
    
    # Verificar que ya no existe
    * path 'characters/' + personajeId
    When method GET
    Then status 404
    # And match response.error == 'Character not found'

  @id:3 @validacionErrores @camposRequeridos
  Scenario: T-API-MARVEL-002-CA03-Validación de campos requeridos - karate
    * def jsonData = {}
    And request jsonData
    When method POST
    Then status 400
    # And match response.name == 'Name is required'
    # And match response.alterego == 'Alterego is required'
    # And match response.description == 'Description is required'
    # And match response.powers == 'Powers are required'
