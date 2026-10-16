# Laboratorio 8: Evaluación y Mejora de UX

## Parte 1.1 Test de usuario

**Test:** una persona que nunca ha usado el proyecto debe poder comprar alimentos, jugar Pizza Rush para obtener un cupón, usar ese cupón en una compra, confirmarla y revisar las estadísticas de su compra, sin recibir explicaciones.

**Flujo a realizar:**
1. Menú principal → Iniciar Simulación.
2. Elegir alimentos → Continuar compra → Confirmar compra.
3. Menú → ¿Te gusta la Pizza? → Jugar Pizza Rush.
4. Entregar las 5 pizzas antes de que acabe el tiempo (cupón de $5000).
5. Nueva compra de $9000 o más con el cupón disponible.
6. Ver Mi Build.

**Acciones que se espera que realice:** navegar entre pantallas, seleccionar alimentos, confirmar la compra, descongelar, cocinar y entregar pizzas, y volver al menú.

**Información que debería comprender:**
- Presupuesto, disponible y total gastado.
- Que el cupón exige una compra mínima y se aplica al confirmar.
- Que la compra se realizó.
- Cómo se juega Pizza Rush y qué significa el resultado final.

**Situaciones a observar:** cuándo pregunta qué hacer, cuándo busca dónde interactuar, cuándo duda entre elementos, cuándo necesita confirmar el resultado de una acción y cuándo debe interpretar información.

**Observaciones de la prueba** (completar al probar con otra persona):

| Momento | Qué ocurrió | Tipo (pregunta / busca / duda / confirma / interpreta) |
|---|---|---|
| | | |
| | | |
| | | |

## Parte 1.2 Mejoras de UX en Pizza Rush

**1. Pizza congelada**
- Situación: al empezar, el jugador ve una pizza azul sin instrucciones y no sabe que debe hacer clic para descongelarla.
- Mejora propuesta: un cursor animado que hace clic sobre la pizza y un texto corto "Haz clic para descongelar".
- Resultado esperado: reconoce que la pizza es interactiva y, al ver el azul volverse blanco con cada clic, entiende que la descongela.

**2. Pizza disponible**
- Situación: la pizza ya descongelada cae sobre la mesa y el jugador no sabe que puede arrastrarla ni hacia dónde.
- Mejora propuesta: cambiar el cursor a una mano al pasar sobre la pizza y mostrar una flecha animada hacia un horno con el texto "Arrástrala al horno".
- Resultado esperado: entiende que debe tomar la pizza y llevarla al horno.

**3. Pizza cocinándose**
- Situación: al soltar la pizza en el horno, el jugador no sabe si funcionó ni que puede acelerar la cocción.
- Mejora propuesta: una barra de progreso sobre el horno y el texto "¡Toca para acelerar!".
- Resultado esperado: sabe que la pizza se está cocinando, cuánto falta y que sus clics aceleran el proceso.

**4. Pizza lista**
- Situación: la pizza termina y el jugador no nota el cambio ni qué hacer después.
- Mejora propuesta: un icono de visto bueno con el texto "¡Lista!" y una flecha parpadeante hacia la zona de entrega.
- Resultado esperado: reconoce que ya puede retirarla y que debe llevarla a la caja.

**5. Zona de entrega**
- Situación: la caja no comunica que es el destino de las pizzas.
- Mejora propuesta: la rotulación "Entrega aquí" y un resaltado de la caja mientras se arrastra una pizza lista.
- Resultado esperado: identifica la caja como el lugar de entrega.

**6. Tiempo restante**
- Situación: el jugador no percibe cuándo se acaba el tiempo.
- Mejora propuesta: el contador cambia a rojo y parpadea en los últimos 10 segundos.
- Resultado esperado: entiende la urgencia y prioriza sus acciones.

## Paso 2.2 Iconos que reforzarían las acciones

| Elemento | Convención | Integración | Texto | ¿Solo icono? |
|---|---|---|---|---|
| Volver / Volver al Menú | Flecha hacia la izquierda | A la izquierda del texto | Indica a dónde se regresa | No: hay varios destinos |
| Confirmar compra | Visto bueno (check) | A la izquierda del texto | Aclara que es la acción de pagar | No: es una acción importante |
| Iniciar Simulación | Triángulo de reproducir | A la izquierda del texto | Indica qué se inicia | No |
| Continuar compra | Carrito | A la izquierda del texto | Indica el siguiente paso | No |
| Configuración | Engranaje | Icono principal, con texto | Nombra la sección | Sí, es muy reconocible |
| Salir | X o puerta | A la izquierda del texto | Evita cerrar por error | No |
| Ayuda de Pizza Rush | Signo de interrogación | Icono en una esquina | Opcional | Sí |

Nota: el proyecto no tiene una acción de eliminar, así que no aplica la papelera.
