# ADR 1: Uso del Patrón Event Bus para Navegación de Escenas

## Estado
Aceptado

## Contexto
En el Laboratorio 1, la navegación se realizaba mediante llamadas directas a `change_scene_to_file` con rutas absolutas de texto, lo que generaba un alto acoplamiento y dependencias rígidas entre los componentes visuales de la interfaz de usuario.

## Decisión
Implementaremos el patrón de diseño Observer combinado con un Singleton Autoload denominado `EventBus`. Un script orquestador centralizado (`MainApp`) gestionará las instancias de escenas basándose en las señales reactivas emitidas por los botones de interfaces.

## Consecuencias
- **Positivas:** Bajo acoplamiento lógico, facilidad para reorganizar directorios sin romper el código.
- **Negativas:** Introduce una pequeña capa de abstracción indirecta.