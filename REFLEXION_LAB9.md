# Reflexión final: Laboratorio 9

**¿Qué ventaja tiene separar los datos de un alimento de la interfaz que lo representa?**
Los datos se pueden editar y reutilizar sin tocar la interfaz. Cambiar un precio o una estadística se hace en el recurso `.tres`, y la interfaz solo decide cómo mostrarlo.

**¿Qué ventaja tiene generar automáticamente los elementos de una interfaz?**
Se evita crear un botón por cada alimento y mantener cada uno por separado. Agregar un alimento nuevo no exige cambiar la escena ni el código.

**¿Qué diferencia existe entre el estado de una interacción y su representación visual?**
El estado es la información que guarda el sistema (qué alimento hay en cada mitad y cuánto cuesta el plato, en `GlobalManager`). La representación visual es cómo se dibuja ese estado (las texturas, el resaltado y las animaciones). Por eso el plato puede reconstruirse desde el estado cuando la escena se recarga.

**¿Qué características permiten que la interfaz pueda crecer sin modificar manualmente cada uno de sus elementos?**
Un catálogo de recursos como única fuente de datos, un contenedor que organiza los botones, un `ScrollContainer` que absorbe más elementos y un código que recorre el catálogo en lugar de nombrar cada alimento.

**¿En qué situaciones considera conveniente utilizar objetos de datos reutilizables dentro de un proyecto?**
Cuando la información forma parte del contenido del juego y se repite con la misma estructura: alimentos, ítems, enemigos, niveles o diálogos. Así se editan desde el Inspector y varias escenas los comparten.
