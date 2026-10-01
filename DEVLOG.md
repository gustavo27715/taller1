## [2026-09-10] - Laboratorio 4: Gestión de Estado Global y Componentes de Navegación Reutilizables

### Actividades Realizadas

* Inicialización de la rama de trabajo `lab-4` para aislar el desarrollo técnico.
* Implementación de `GlobalManager` mediante un Autoload para administrar
  el estado global de la simulación.
* Integración del estado de precios y cantidades mediante señales del Event Bus.
* Actualización reactiva del precio total mostrado en `Step1Base`.
* Creación del componente reutilizable `ButtonNav` utilizando `export target_scene`.
* Refactorización de los botones de navegación y adaptación de `MainApp`.
* Incorporación de la propiedad `discard_previous` como punto de extensión.

### Desafíos y Soluciones

* *Desafío:* Separar la administración del estado de la interfaz gráfica.
* *Solución:* Se centralizó el estado de la simulación en `GlobalManager` y
  se utilizó el Event Bus para comunicar los cambios.

* *Desafío:* Diseñar un componente de navegación que pueda reutilizarse y evolucionar.
* *Solución:* Se creó `ButtonNav` como una escena reutilizable, permitiendo
  configurar su destino y agregar comportamientos desde un único componente.

### Decisiones Arquitectónicas

* Se implementó el patrón Event Bus para eliminar llamadas directas cruzadas.
* Se documentó la decisión mediante el estándar ADR-003.
* Se eliminaron `config_panel.gd` y `credits_panel.gd` para simplificar mantenibilidad.


## [2026-09-30] - Laboratorio 6: Máquina de Estado Finito y Animaciones Programáticas

### Actividades Realizadas

* Reorganización de escenas: carpeta `gamification/catch_food/` para el minijuego anterior (Lab 5).
* Creación de la carpeta `gamification/pizza_rush/` con assets propios.
* Implementación de un minijuego "Pizza Rush" con sistema de preparación y entrega de pizzas.
* Diseño de una Máquina de Estado Finito (FSM) en `pizza.gd` con 6 estados: CONGELADA, DISPONIBLE, ARRASTRANDO, COCINANDO, LISTA, ENTREGADA.
* Implementación de transiciones validadas mediante `change_state()` con reglas estrictas.
* Creación de escenas reutilizables: `pizza.tscn`, `oven.tscn`, `pizza_spawn.tscn`.
* Implementación de la zona de entrega (`DeliveryArea`) con señal `pizza_delivered`.
* Creación del controlador de partida (`pizza_rush_main.gd`) con sistema de progreso y temporizador.
* Integración del minijuego con el EventBus para comunicar la recompensa (`coupon_obtained`).
* Implementación de animaciones programáticas con `Tween` para cada transición de estado.
* Modificación del `mouse_filter` del `SceneContainer` de `Stop` a `Pass` para permitir la interacción del mouse.

### Desafíos y Soluciones

* *Desafío:* Modelar el ciclo de vida de una pizza con múltiples estados que dependen del contexto.
* *Solución:* Se implementó una FSM con estados claramente definidos y transiciones validadas mediante `match`, evitando que la pizza realice acciones incompatibles con su estado actual.

* *Desafío:* La misma entrada del mouse (clic) debe producir diferentes comportamientos según el estado de la pizza.
* *Solución:* Cada método `process_*` interpreta la entrada según su estado: en CONGELADA acelera el timer, en DISPONIBLE inicia el arrastre, en COCINANDO acelera la cocción, etc.

* *Desafío:* Sincronizar el descuento del cupón con el sistema de compra sin afectar el presupuesto acumulado.
* *Solución:* Se separó el cálculo del subtotal (`current_total`) del total con descuento (`final_total`), aplicando el descuento solo al confirmar la compra mediante `confirm_purchase()`.

* *Desafío:* El mouse no interactuaba con las pizzas dentro del `SceneContainer`.
* *Solución:* Se cambió la propiedad `mouse_filter` del `SceneContainer` de `Stop` a `Pass`, permitiendo que los nodos hijos reciban los eventos del mouse.

### Decisiones Arquitectónicas

* Se implementó el patrón **Máquina de Estado Finito (FSM)** para modelar el comportamiento de la pizza.
* Se utilizaron **Tweens** para representar visualmente las transiciones entre estados.
* Se documentó la decisión mediante el estándar **ADR-005**.
* Se mantuvo el principio de **Co-localización**: cada escena comparte directorio con su script controlador.
* Se preservó la organización y nomenclatura en **snake_case** adoptada en laboratorios anteriores.
* Se utilizó el **EventBus** para comunicar la recompensa al sistema global sin acoplamiento directo.
