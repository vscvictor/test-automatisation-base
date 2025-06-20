@REQ_MARVEL-001 @HU001 @character_management @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: MARVEL-001 Gestión de Personajes Marvel (microservicio para administrar personajes de Marvel)

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

      # Get all characters and extract firstId
    * def firstId = 50

  @id:1 @obtenerPersonajes @solicitudExitosa200
  Scenario: T-API-MARVEL-001-CA01-Obtener todos los personajes 200 - karate
    When method GET
    Then status 200
    # And match response != null
    # And match response == '#array'

  @id:2 @obtenerPersonajePorId @solicitudExitosa200
  Scenario: T-API-MARVEL-001-CA02-Obtener personaje por ID 200 - karate
    When method GET
    Then status 200
    * def firstId1 = response[8].id
    * def personajeId = firstId1
    * path 'characters/' + personajeId
    When method GET
    Then status 200
    # And match response != null
    # And match response.id == 1

  @id:3 @obtenerPersonajePorId @noEncontrado404
  Scenario: T-API-MARVEL-001-CA03-Obtener personaje por ID inexistente 404 - karate
    * def personajeId = '9999'
    * path '/' + personajeId
    When method GET
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: 'Character not found' }

  @id:4 @crearPersonaje @creacionExitosa201
  Scenario: T-API-MARVEL-001-CA04-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/character_create_2.json')
    * def randomName = 'I2_' + java.util.UUID.randomUUID()
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    # And match response != null
    # And match response.id != null

  @id:5 @crearPersonaje @errorValidacion400
  Scenario: T-API-MARVEL-001-CA05-Crear personaje con campos inválidos 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/character_invalid.json')
    And request jsonData
    When method POST
    Then status 400
    # And match response.name == 'Name is required'
    # And match response.alterego == 'Alterego is required'

  @id:6 @crearPersonaje @errorDuplicado400
  Scenario: T-API-MARVEL-001-CA06-Crear personaje con nombre duplicado 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/character_create.json')
    And request jsonData
    When method POST
    Then status 400
    # And match response.error == 'Character name already exists'
    # And match response == { error: 'Character name already exists' }

  @id:7 @actualizarPersonaje @actualizacionExitosa200
  Scenario: T-API-MARVEL-001-CA07-Actualizar personaje exitosamente 200 - karate
    When method GET
    Then status 200
    * def firstId1 = response[8].id
    * def personajeId = firstId1
    * path 'characters/' + personajeId
    * def jsonData = read('classpath:data/marvel_characters_api/character_update.json')
    And request jsonData
    When method PUT
    Then status 200
    # And match response != null
    # And match response.description == 'Updated description'

  @id:8 @actualizarPersonaje @noEncontrado404
  Scenario: T-API-MARVEL-001-CA08-Actualizar personaje inexistente 404 - karate
    * def personajeId = '999'
    * path '/' + personajeId
    * def jsonData = read('classpath:data/marvel_characters_api/character_update.json')
    And request jsonData
    When method PUT
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: 'Character not found' }

  @id:9 @eliminarPersonaje @eliminacionExitosa204
  Scenario: T-API-MARVEL-001-CA09-Eliminar personaje exitosamente 204 - karate
    When method GET
    Then status 200
    * def firstId1 = response[5].id
    * def personajeId = firstId1
    * path 'characters/' + personajeId
    When method DELETE
    Then status 204
    # And match response == ''
    # And match response == null

  @id:10 @eliminarPersonaje @noEncontrado404
  Scenario: T-API-MARVEL-001-CA10-Eliminar personaje inexistente 404 - karate
    * def personajeId = '999'
    * path '/' + personajeId
    When method DELETE
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: 'Character not found' }

  @id:11 @errorServicio500
  Scenario: T-API-MARVEL-001-CA11-Error interno del servidor 500 - karate
    * def errorId = '500'
    * path '/error/' + errorId
    When method GET
    Then status 500
    # And match response.error contains 'Internal Server Error'
    # And match response.status == 500
