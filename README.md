# 🏋️ Gym Microservices - Setup Project

Setup completo para el ecosistema de microservicios del gimnasio, incluyendo scripts de automatización, documentación y herramientas de desarrollo.

## 📋 Contenido del Proyecto

### 🔧 Scripts de Automatización

- `clone_repos.sh` - Script para clonar todos los microservicios
- `update_repos.sh` - Script para actualizar todos los microservicios

### 🐳 Orquestación

- `docker-compose.yml` - Configuración para levantar todos los servicios

### 📚 Documentación y Recursos

- `Gym Microservices - Components Diagram.pdf` - Diagrama de componentes del sistema
- `Gym Microservices - Components Diagram.vpp` - Archivo fuente del diagrama (Visual Paradigm)
- `gym.postman_collection.json` - Colección de Postman con todas las APIs

### ⚙️ Configuración

- `.gitignore` - Configuración para evitar subir los microservicios clonados

## 🏗️ Arquitectura de Microservicios

El proyecto está compuesto por los siguientes microservicios:

| Microservicio                 | Descripción                           | Tecnología                  |
| ----------------------------- | ------------------------------------- | --------------------------- |
| **eureka-server**             | Servidor de registro y descubrimiento | Spring Cloud Netflix Eureka |
| **gateway**                   | API Gateway principal                 | Spring Cloud Gateway        |
| **core-microservice**         | Lógica central                        | Java/Spring Boot            |
| **member-microservice**       | Gestión de miembros                   | Java/Spring Boot            |
| **coach-microservice**        | Gestión de entrenadores               | Java/Spring Boot            |
| **class-microservice**        | Gestión de clases                     | Java/Spring Boot            |
| **equipament-microservice**   | Gestión de equipamiento               | Java/Spring Boot            |
| **payment-microservice**      | Procesamiento de pagos                | Java/Spring Boot            |
| **notification-microservice** | Sistema de notificaciones             | Java/Spring Boot            |
| **parent**                    | Configuración Maven padre             | Maven POM                   |
| **.github**                   | Files                                 | GitHub files                |
