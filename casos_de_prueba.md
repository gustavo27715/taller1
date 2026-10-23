# Documentación de Casos de Prueba y Depuración - Laboratorio 10

## Parte 1: Registro de Depuración (Breakpoint)

* **¿Qué aprendió?** Aprendí a pausar la ejecución del código en un punto exacto (breakpoint) para observar el estado de las variables en tiempo real. Esto es especialmente útil en un proyecto con múltiples escenas y señales, ya que permite rastrear el flujo exacto de los datos (por ejemplo, cómo viaja un cupón desde el minijuego hasta el `GlobalManager`) sin tener que adivinar qué está pasando.
* **¿Le resultó útil?** Sí, fue muy útil para comprender la comunicación asíncrona. Al entrar paso a paso (Step Over) en las funciones, pude comprobar cómo los argumentos llegaban con los valores esperados y cómo la pila de llamadas (Stack Trace) mostraba desde qué escena o script se había disparado la acción.
* **Ejemplo:** Pude inspeccionar la variable `subtotal` dentro de la función `get_best_coupon()`. Al pausar la ejecución justo después de calcular el subtotal, confirmé que el valor era exactamente el esperado (por ejemplo, 12000), lo que me aseguró que el problema (si lo hubiera) no estaba en el cálculo previo, sino en la comparación de los cupones.

---

## Parte 2: Casos de Prueba

### Caso de prueba: UNI-01 - Selección del mejor cupón

* **Tipo:** Unitaria
* **Objetivo:** Verificar que `GlobalManager.get_best_coupon(subtotal)` seleccione correctamente el mejor cupón disponible según el subtotal de la compra.
* **Automatizada en:** `tests/test_global_manager.gd`

**Casos de prueba:**

* **Caso 1 - Cupón válido**
  * **Entrada:** Un cupón de valor 2000 y compra mínima de 10000. Subtotal: 12000.
  * **Resultado esperado:** Se devuelve el cupón de valor 2000.
* **Caso 2 - Compra inferior al mínimo**
  * **Entrada:** Un cupón de valor 2000 y compra mínima de 10000. Subtotal: 9999.
  * **Resultado esperado:** Se devuelve un diccionario vacío `{}`.
* **Caso 3 - Selección del cupón de mayor valor**
  * **Entrada:** Dos cupones: uno de valor 1000 y compra mínima de 5000; otro de valor 3000 y compra mínima de 10000. Subtotal: 12000.
  * **Resultado esperado:** Se devuelve el cupón de valor 3000.

**Resultado de la ejecución:**
* **Casos aprobados:** 3 de 3
* **Casos fallidos:** 0 de 3
* **Detalle de los fallos:** Ninguno. No hubo casos fallidos.
* **Conclusión:** `get_best_coupon` cumple los tres casos evaluados: devuelve el cupón cuando el subtotal alcanza el mínimo, devuelve un diccionario vacío cuando no lo alcanza y elige el cupón de mayor valor cuando hay varios válidos. Se aprendió que una función de `GlobalManager` se puede probar de forma aislada, sin agregarlo al árbol de escenas, y que al asignar cupones hay que respetar el tipo `Array[Dictionary]`.

---

### Caso de prueba: INT-01 - Registro de un cupón obtenido

* **Tipo:** Integración
* **Objetivo:** Verificar que la señal `EventBus.coupon_obtained` comunique correctamente la obtención de un cupón y que `GlobalManager` lo registre.

**Casos de prueba:**

* **Caso 1 - Recepción del evento**
  * **Condición inicial:** La conexión de la señal está activa.
  * **Entrada:** Se emite un cupón de prueba mediante `EventBus.coupon_obtained(coupon)`.
  * **Resultado esperado:** `GlobalManager` recibe el evento y agrega el cupón a su lista.
* **Caso 2 - Conservación de los datos**
  * **Condición inicial:** El cupón de prueba contiene un valor y un monto mínimo conocidos.
  * **Resultado esperado:** El cupón registrado conserva ambos valores.

**Resultado de la ejecución:**
* **Casos aprobados:** Pendiente de ejecución manual
* **Casos fallidos:** Pendiente de ejecución manual
* **Detalle de los fallos:** Pendiente
* **Conclusión:** Pendiente hasta ejecutar la prueba.

---

### Caso de prueba: SIS-01 - Obtención y persistencia de un cupón

* **Tipo:** Sistema
* **Objetivo:** Verificar el flujo completo de obtención, persistencia y uso de un cupón dentro del juego.

**Casos de prueba:**

* **Caso 1 - Obtención de la recompensa**
  * **Entrada:** Iniciar el juego y completar correctamente el minijuego.
  * **Resultado esperado:** El jugador obtiene el cupón de recompensa.
* **Caso 2 - Persistencia**
  * **Entrada:** Cerrar y volver a abrir la aplicación.
  * **Resultado esperado:** El cupón continúa disponible.
* **Caso 3 - Uso del cupón**
  * **Entrada:** Realizar una compra que cumpla las condiciones del cupón y aplicarlo.
  * **Resultado esperado:** El cupón se aplica y el total de la compra se calcula correctamente.
* **Caso 4 - Persistencia del consumo**
  * **Entrada:** Finalizar la compra, cerrar y volver a abrir la aplicación.
  * **Resultado esperado:** El cupón consumido no vuelve a aparecer como disponible.

**Resultado de la ejecución:**
* **Casos aprobados:** Pendiente de ejecución manual
* **Casos fallidos:** Pendiente de ejecución manual
* **Detalle de los fallos:** Pendiente
* **Conclusión:** Pendiente hasta ejecutar la prueba.

---

### Caso de prueba: RET-01 - Presupuesto disponible del plato (Reto Autónomo)

* **Tipo:** Unitaria
* **Objetivo:** Verificar que `GlobalManager.get_plate_available_budget()` calcule `presupuesto mensual - gasto acumulado - total del plato`.
* **Automatizada en:** `tests/test_plate_functions.gd`

**Casos de prueba:**

* **Caso 1 - Positivo**
  * **Entrada:** Presupuesto 20000, gastado 5000, plato 3000.
  * **Resultado esperado:** Devuelve 12000.
* **Caso 2 - Negativo**
  * **Entrada:** Presupuesto 20000, gastado 0, plato 25000.
  * **Resultado esperado:** Devuelve -5000 (el plato supera el presupuesto).
* **Caso 3 - Límite**
  * **Entrada:** Presupuesto 20000, gastado 15000, plato 5000.
  * **Resultado esperado:** Devuelve 0.

**Resultado de la ejecución:**
* **Casos aprobados:** 3 de 3
* **Casos fallidos:** 0 de 3
* **Detalle de los fallos:** Ninguno. No hubo casos fallidos.
* **Conclusión:** `get_plate_available_budget` cumple los casos evaluados, incluidos el plato que supera el presupuesto (devuelve un valor negativo) y el límite exacto (devuelve 0). La función solo calcula el valor; la prueba no verifica cómo reacciona la interfaz cuando el resultado es negativo.

---

### Caso de prueba: RET-02 - Estadísticas del plato (Reto Autónomo)

* **Tipo:** Unitaria
* **Objetivo:** Verificar que `GlobalManager.get_plate_stats()` sume las estadísticas de los alimentos del plato usando el catálogo real.
* **Automatizada en:** `tests/test_plate_functions.gd`

**Casos de prueba:**

* **Caso 1 - Positivo**
  * **Entrada:** Mitad izquierda "carne", mitad derecha "tocino".
  * **Resultado esperado:** salud 1, velocidad 3, salto 2, energía 14.
* **Caso 2 - Negativo**
  * **Entrada:** Mitad izquierda "xyz" (id inexistente), mitad derecha vacía.
  * **Resultado esperado:** salud 0, velocidad 0, salto 0, energía 0.
* **Caso 3 - Límite**
  * **Entrada:** Mitad izquierda "carne", mitad derecha vacía.
  * **Resultado esperado:** salud 3, velocidad 1, salto 2, energía 8.

**Resultado de la ejecución:**
* **Casos aprobados:** 3 de 3
* **Casos fallidos:** 0 de 3
* **Detalle de los fallos:** Ninguno. No hubo casos fallidos.
* **Conclusión:** `get_plate_stats` cumple los casos evaluados con los alimentos reales del catálogo: suma correctamente las estadísticas de dos alimentos, ignora un id inexistente y funciona con una sola mitad del plato. Se aprendió que probar con el catálogo real también comprueba que los datos de los archivos `.tres` coincidan con lo esperado.
