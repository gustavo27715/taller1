# Proyecto Integrador - Sprint 1

## Descripción
Simulador interactivo con Godot 4.x y renderizador Compatibility.

## Estructura del Proyecto
- `src/scenes/main.tscn` - Menú principal
- `src/scenes/main_level_1.tscn` - Selección de ingredientes
- `src/scripts/` - Scripts con tipado estático

## Interacción
- Iniciar Simulación: Navega a la pantalla de selección
- Seleccionar Ingrediente: Muestra nombre y costo
- Salir: Cierra la aplicación

## Tecnologías
- Godot 4.x (Compatibility)
- GDScript 2.0
- Git/GitHub

## [Sprint 1] - Laboratorio 2: Escenas, Nodos y Eventos

- **Fecha:** [02/09/2026]
- **Funcionalidades:** Implementación exitosa de un sistema de navegación desacoplado entre 4 entornos modulares (Menú, Simulación Base, Configuración y Créditos) utilizando un cargador dinámico centralizado (`MainApp`) y escenas Control de UI.
- **Dificultades:** Comprensión del tipado estático (`-> void`) y la resolución del ámbito de carga de variables dinámicas y errores al cambiar de escena .
- **Decisiones:** Se implementó el patrón Event Bus para eliminar llamadas directas cruzadas, erradicando el antipatrón de dependencias rígidas. Se documentó la decisión mediante ADR-1.
