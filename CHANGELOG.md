# Changelog

Todos los cambios notables de este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es/1.0.0/),
y este proyecto se adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2026-09-10

### Added
- `GlobalManager` como Autoload para centralizar el estado global de la simulación
- Señal `budget_changed` en el EventBus para notificar cambios en el presupuesto
- Presupuesto mensual de $20,000 con alertas visuales (blanco/naranja/rojo)
- Componente `ButtonNav` reutilizable con `@export target_scene` y `@export discard_previous`
- Pila de historial de navegación (`navigation_history`) en `MainApp`
- Documentación ADR-003 sobre GlobalManager y ButtonNav
- Archivo CHANGELOG.md

### Changed
- `event_bus.gd` actualizado con 4 señales tipadas estáticamente
- `Step1Base` ahora es 100% reactivo al EventBus (sin referencias directas a GlobalManager)
- `MainApp` adaptado con pila de historial (`.append()` / `.pop_back()`)
- `menu_panel.gd` simplificado (solo maneja botón salir)
- Estructura de precios modificada a acumulativa (Opción C)

### Removed
- `config_panel.gd` (navegación ahora declarativa vía ButtonNav)
- `credits_panel.gd` (navegación ahora declarativa vía ButtonNav)

### Fixed
- Error de "2 argumentos esperados" en `navigation_requested`
- Error de "Node not found" en botones de Step1Base
- Botón Volver en Step1Base ahora usa ButtonNav correctamente
