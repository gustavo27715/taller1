# Registro de Decisión de Arquitectura (ADR)

## ADR-005: Máquina de Estado Finito y Animaciones Programáticas

* **Estado:** Aprobado
* **Fecha:** 30/09/2026
* **Autor:** Gustavo Rodriguez

### Contexto

El minijuego "Pizza Rush" maneja varias pizzas simultáneas, cada una con un
ciclo de vida distinto: congelada, disponible, arrastrada, cocinándose, lista
y entregada. Una misma entrada del jugador (el clic izquierdo) debe significar
cosas diferentes según la situación: acelerar la descongelación, tomar la
pizza, acelerar la cocción o soltarla. Resolver esto con condicionales
dispersos y banderas booleanas dificulta la lectura y permite combinaciones
de estado inválidas. Además, los cambios de estado deben comunicarse
visualmente al jugador.

### Decisión

Se implementará una Máquina de Estado Finito en `pizza.gd`, con un `enum
PizzaState`, un `current_state` y un `previous_state`. Cada instancia de
`Pizza.tscn` mantiene su propia FSM de forma independiente.

La validación de transiciones se centraliza en `change_state()`, que rechaza
cualquier cambio no permitido y devuelve un booleano. El horno y la zona de
entrega solo reaccionan cuando la transición fue válida.

El comportamiento de cada estado (`process_<estado>()`) se separa de las
acciones asociadas a una transición (animaciones, activar el horno, confirmar
la entrega). Un único `Timer` por pizza se reutiliza porque la pizza solo está
en un estado a la vez.

Las transiciones se representan mediante Tweens, seleccionados según la pareja
`previous_state` y `current_state` en `play_transition_animation()`.

El resultado de la partida se comunica con la señal `pizza_delivered` y con el
Event Bus (`coupon_obtained`), sin que el minijuego acceda al sistema de compra.

### Consecuencias

* **Positivas:**
  * Las reglas del flujo están en un solo lugar y son fáciles de auditar.
  * Una pizza no puede realizar acciones incompatibles con su estado.
  * Agregar un estado implica extender el `enum`, `change_state()` y una función de proceso.
  * Las animaciones responden a la transición y no solo al estado final.
  * El minijuego queda desacoplado del sistema de compra gracias al Event Bus.

* **Negativas / Costos:**
  * La FSM vive en un solo script que crece con cada estado y no es reutilizable entre entidades.
  * Las transiciones se definen en un `match` manual que debe mantenerse sincronizado con el diagrama de flujo.
  * Combinar Tweens con interpolación por `lerp` en el arrastre exige coordinarlos para que no compitan por la escala.
  * Las animaciones son difíciles de probar automáticamente y requieren verificación visual.
