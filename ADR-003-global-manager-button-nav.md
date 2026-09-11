# Registro de Decisión de Arquitectura (ADR)

## ADR-003: Gestión de Estado Global y Componentes de Navegación Reutilizables

* **Estado:** Aprobado
* **Fecha:** 10/09/2026
* **Autor:** Gustavo Rodriguez

### Contexto

El proyecto utiliza un Event Bus para desacoplar la comunicación entre
componentes. Sin embargo, algunas funcionalidades requieren mantener
información compartida entre diferentes escenas, como el estado de una
simulación y su precio total.

Además, existen comportamientos de navegación que pueden ser encapsulados
en un componente reutilizable y posteriormente ampliados con nuevas
capacidades.

### Decisión

Se implementará un GlobalManager como Autoload para administrar el estado
global de la simulación, incluyendo precios, cantidades y total actual.

La comunicación entre la interfaz y el GlobalManager se realizará mediante
señales del Event Bus.

También se implementará un componente ButtonNav basado en una escena
reutilizable, cuyo destino será definido mediante una propiedad exportada.

ButtonNav podrá incorporar comportamientos adicionales relacionados con la
navegación sin que las escenas que lo utilizan tengan que implementar
individualmente dichas funcionalidades.

### Consecuencias

* **Positivas:**
  * El estado global permanece independiente de las escenas visuales.
  * Los precios se encuentran centralizados.
  * La interfaz no necesita conocer directamente al administrador global.
  * Los cambios de estado pueden comunicarse mediante señales.
  * El comportamiento de navegación puede reutilizarse en diferentes escenas.
  * Las nuevas capacidades de ButtonNav pueden implementarse desde un único componente.

* **Negativas / Costos:**
  * Se introduce una capa adicional de comunicación mediante señales.
  * El flujo de ejecución puede requerir seguir varios componentes para comprender
	completamente una acción.
  * El estado global debe administrarse cuidadosamente.
  * Una abstracción reutilizable puede crecer en complejidad si se le agregan
	demasiadas responsabilidades.
