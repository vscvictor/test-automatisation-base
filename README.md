# README

Arquetipo de pruebas automatizadas de APIs usando la herramienta karate

Realizadas por:  EquipoE2E

## Complementos

|**Intellij**|                                                                                           **JDK 21**                                                                                           |                                                       **Gradle 8.7**                                                       |
| :----: |:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------:|
|[<img width="50" height="50" src="https://cdn.iconscout.com/icon/free/png-128/intellij-idea-569199.png">](https://www.jetbrains.com/es-es/idea/download/#section=windows)| [<img height="60" src="https://imagedelivery.net/-IT6z0z0Ec5yEiYj3DvVjg/4a05ca76db1fa48640b21658f2659ac656492b82/public">](https://learn.microsoft.com/es-es/java/openjdk/download#openjdk-21) | [<img height="50" src="https://gradle.org/images/gradle-knowledge-graph-logo.png?20170228">](https://gradle.org/releases/) |
> **NOTA**:
> * Una vez obtenido Intellij es necesario instalar los plugins de Gherkin, Cucumber y Karate. (*[Guia de instalación plugins en intellij](https://www.jetbrains.com/help/idea/managing-plugins.html)*)
>

## Ejecución local

Clonar el proyecto

```bash
  git clone https://dev.azure.com/BancoPichinchaEC/BP-Quality-Management/_git/sqa-aut-arq-karate
```

Entrar al directorio del proyecto

```bash
  cd sqa-aut-arq-karate
```
## Modificación del codigo

- Para realizar modificaciones al codigo del proyecto. realizar los siguientes pasos: 

     
	 1. Importar el proyecto desde IntelliJ IDE bajo la estructura de un proyecto Gradle existente
     2. Verificar variables de entorno JAVA_HOME(C:\Program Files\Microsoft\jdk-21.0.3.9-hotspot) y GRADLE_HOME(C:\Gradle\gradle-8.7)
	 3. Configurar la codificación a UTF-8 al proyecto una vez sea importado

## Comandos

Para ejecutar todos los features por linea de comandos
```bash
  ./gradlew clean test 
```

Para ejecutar todos los escenarios que contengan un tag especifico
```bash
  ./gradlew clean test "-Dkarate.options=--tags @test"
```

Para ejecutar los escenarios enviando variables de ambiente
```bash
  ./gradlew clean test "-Dkarate.options=--tags @test" -Dvariable=test
```
> **NOTA**:
> * Para ejecutar el proyecto se necesita OpenJDK 21 y Gradle 8.7.
> * Otra alternativa para no instalar gradle es usar el comando gradlew al momento de ejecutar el proyecto como se muestro anteriormente.
> * Luego de la ejecucion de pruebas, los reportes se generan en la carpeta **build/karate-reports/**, y el archivo de resumen es el **karate-summary.html**

## La automatización fue desarrollada con:

* BDD - Estrategia de desarrollo
* Gradle - Manejador de dependencias
* karate/Cucumber - Framework para automatizar pruebas de API
* Gherkin - Lenguaje Business Readable DSL (Lenguaje especifico de dominio legible por el negocio)

## Documentacion

[Manual Karate](https://dev.azure.com/BancoPichinchaEC/BP-Quality-Management/_wiki/wikis/BP-Quality-Management.wiki/590/Manual-Arquetipo-Karate-Cucumber)

