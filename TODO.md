# TODO: Guía de Implementación Detallada y Explícita

## Objetivo Principal

Reestructurar el código actual para crear una única base de simulación que sea robusta, flexible y directamente alineada con los objetivos de la tesis. Esto implica eliminar código duplicado y hacer que el sistema sea configurable y capaz de simular los escenarios de riesgo necesarios para tu investigación.

Este documento se divide en dos partes: una guía para la escritura de la tesis y una hoja de ruta técnica para la implementación en el código.

---

## Parte I: Guía para la Redacción de la Tesis

### **Marco Teórico**

**Objetivo:** Demostrar que dominas los fundamentos científicos sobre los que se construye tu trabajo.

1.  **Simulación de Eventos Discretos (DES):**
    *   **Qué Escribir:** Define este paradigma como un método computacional para modelar sistemas cuyo estado cambia en instantes discretos de tiempo por la ocurrencia de "eventos".
    *   **Por qué es Relevante:** Es el enfoque ideal para tu problema, ya que la logística (llegada de un camión, una orden de compra, inicio de una tormenta) se modela perfectamente como una secuencia de eventos discretos.
    *   **Conexión con tu Código:** Menciona que tu herramienta de implementación es **SimPy**, una biblioteca estándar y validada en Python para DES.

2.  **Resiliencia en Cadenas de Suministro:**
    *   **Qué Escribir:** Define la resiliencia no solo como la capacidad de resistir una disrupción, sino como la **capacidad de absorber el impacto, adaptarse y recuperarse de ella**. Cita a autores clave como Martin Christopher o Yossi Sheffi.
    *   **Por qué es Relevante:** Es el concepto central de tu tesis. No solo quieres modelar la cadena de suministro, sino entender cómo se comporta ante fallas y cómo mejorar su capacidad de recuperación.
    *   **Conexión con tu Código:** Tu `GestorDisrupciones` es la materialización de esta teoría. Permite inyectar fallas (eventos disruptivos) en el sistema y medir su impacto, sentando las bases para evaluar la resiliencia.

3.  **Modelado Estocástico y Análisis de Riesgos:**
    *   **Qué Escribir:** Explica que el mundo real es incierto (estocástico). Por tanto, un modelo realista no puede usar valores fijos para todo. Debes usar distribuciones de probabilidad para representar variables como tiempos de viaje, duración de fallas, etc.
    *   **Por qué es Relevante:** Aporta realismo y permite obtener no una única respuesta, sino un rango de posibles resultados, lo cual es fundamental en el análisis de riesgos.
    *   **Conexión con tu Código:** Tu clase `DistribucionEstocastica` y el uso de distribuciones como Exponencial, Lognormal y Triangular en el `GestorDisrupciones` son la implementación directa de esta teoría.

### **Estado del Arte**

**Objetivo:** Demostrar que tu trabajo es novedoso y aporta valor sobre lo que ya existe.

1.  **Estrategia de Búsqueda:**
    *   Realiza una búsqueda de artículos científicos y tesis usando palabras clave, yendo de lo general a lo específico: "supply chain simulation" -> "energy supply chain simulation" -> "supply chain resilience simulation" -> "LPG logistics disruption modeling".

2.  **Identifica el "Gap" que tu Tesis Llena:**
    *   **El vacío en la literatura:** Probablemente encontrarás que muchos modelos son teóricos o usan datos genéricos. Es raro encontrar trabajos que combinen los tres pilares que tú tienes:
        1.  **Un caso de estudio real,** detallado y validado con datos de un informe técnico (`INFORME FINAL ESTUDIO.pdf`).
        2.  **Un motor de simulación de disrupciones multi-causa,** con un catálogo de riesgos tan extenso (77 tipos) como el que tienes en `eventos.py`.
        3.  **Un enfoque en evaluar soluciones de infraestructura concretas** (aumento de almacenamiento, nuevas rutas, etc.), conectando la simulación con la toma de decisiones de política pública.
    *   **Qué Escribir:** Redacta tu estado del arte concluyendo que, si bien existen modelos de simulación para logística, hay una oportunidad para aplicar estos modelos a casos reales y complejos como el de Aysén, utilizando un framework de disrupciones avanzado para evaluar cuantitativamente estrategias de mitigación.

---
---

## Parte II: Hoja de Ruta Técnica para el Código

### **Fase 1: Unificar las Entidades del Modelo**

**Meta:** Eliminar la duplicidad entre `entidades.py` y `entidades_aysen.py`. Tendremos un único archivo, `entidades.py`, con clases genéricas que se configuran desde los archivos YAML.

*   **Tarea 1.1: Crear un `NodoLogistico` genérico.**
    *   **Qué hacer:** Renombrar `PlantaAlmacenamiento` en `entidades.py` a `NodoLogistico`.
    *   **Detalle:** Modificar su constructor (`__init__`) para que pueda manejar múltiples tipos de inventario. En lugar de un solo `simpy.Container`, usará un diccionario. El archivo de configuración definirá qué inventarios tiene cada nodo.
    *   **Ejemplo de código:**
        ```python
        # En el constructor de NodoLogistico
        self.inventarios: Dict[str, simpy.Container] = {}
        # La configuración 'config' vendrá del archivo YAML
        for nombre_inv, config_inv in config.get('inventarios', {}).items():
            self.inventarios[nombre_inv] = simpy.Container(env, capacity=config_inv['capacidad'], init=config_inv['inicial'])
        ```
    *   **Por qué:** Con esta única clase `NodoLogistico`, podremos representar el `HubCoyhaique` (que tiene inventario `granel` y `envasado`), la `RedCDE` (que solo tiene `envasado`) y los `ClientesFinales` (que también tienen dos tipos de inventario). Se elimina la necesidad de tener clases separadas para cada uno.

*   **Tarea 1.2: Unificar la lógica de los Camiones.**
    *   **Qué hacer:** Migrar la lógica específica de `CamionCisterna` (de `entidades_aysen.py`) a la clase `Camion` (de `entidades.py`).
    *   **Detalle:** La lógica que calcula el tiempo de viaje según la estación del año (verano/invierno) debe ser un atributo configurable de la clase `Camion`. En lugar de una sola distribución de probabilidad para el tiempo de viaje, la clase `Camion` podrá tener varias y una función que decida cuál usar según el día de la simulación.
    *   **Por qué:** Esto hace que la clase `Camion` sea más potente y evita tener dos clases de camiones casi idénticas.

*   **Tarea 1.3: Eliminar código obsoleto.**
    *   **Qué hacer:** Una vez que toda la funcionalidad de `entidades_aysen.py` esté representada por las clases genéricas de `entidades.py`, eliminar el archivo `entidades_aysen.py` por completo.
    *   **Por qué:** Para reducir la complejidad y la posibilidad de errores al tener dos fuentes de verdad.

### **Fase 2: Conectar el Motor de Disrupciones**

**Meta:** Hacer que la simulación principal (`modelo_aysen.py`) utilice el `GestorDisrupciones` (`eventos.py`) para poder simular fallas.

*   **Tarea 2.1: Instanciar el Gestor en la Simulación Principal.**
    *   **Qué hacer:** En el archivo `modelo_aysen.py`, dentro de la clase `SimulacionAysen`, crear una instancia del gestor.
    *   **Detalle:** En el `__init__` de `SimulacionAysen`, añadir la línea: `self.gestor_disrupciones = GestorDisrupciones(self.env, self.rng)`.

*   **Tarea 2.2: Cargar y Activar los Riesgos desde el Archivo de Configuración.**
    *   **Qué hacer:** Leer la sección `riesgos` del archivo YAML y pasarla al gestor.
    *   **Detalle:** En el método de inicialización de `SimulacionAysen`, añadir: `self.gestor_disrupciones.configurar_riesgos_yaml(self.config['riesgos'])`.

*   **Tarea 2.3: Registrar las Entidades para que Puedan Ser Afectadas.**
    *   **Qué hacer:** Informar al gestor de disrupciones cuáles son las entidades que existen en la simulación (el hub, los camiones, etc.).
    *   **Detalle:** Después de crear las instancias del hub, la red de CDEs y los camiones, llamar a `self.gestor_disrupciones.registrar_entidad()` por cada una de ellas.
    *   **Por qué:** El gestor necesita saber qué entidades existen para poder aplicarles los efectos de las disrupciones (ej. "bloquear acceso" a un `NodoLogistico` o "aumentar tiempo de viaje" a un `Camion`).

### **Fase 3: Simplificar la Lógica de Transporte**

**Meta:** Eliminar el archivo `transporte.py` y mover su lógica de decisión a la simulación principal de una forma más limpia y modular.

*   **Tarea 3.1: Extraer las "Políticas de Reabastecimiento".**
    *   **Qué hacer:** La lógica que decide cuándo enviar un camión (ej. "si el inventario del hub es menor a 200 toneladas, enviar camiones") debe ser extraída de las clases `GestorTransportePrimario` y `GestorDistribucionRegional`.
    *   **Detalle:** Se puede crear una nueva clase o simplemente un método dentro de `SimulacionAysen` que se encargue de esto. Este método ya no se ejecutará en un bucle de `yield self.env.timeout(1.0)`, sino que se activará por eventos (ej. un evento que indique que el nivel de inventario es bajo).
    *   **Por qué:** Esto separa la "decisión" de la "acción". Las entidades (camiones, nodos) solo realizan acciones, mientras que la simulación principal contiene las reglas de negocio que coordinan a esas entidades. Esto hace el código mucho más fácil de entender y modificar.

*   **Tarea 3.2: Eliminar archivo obsoleto.**
    *   **Qué hacer:** Una vez que la lógica de decisión se haya movido, el archivo `transporte.py` quedará vacío o casi vacío, y deberá ser eliminado.

### **Fase 4: Mejorar el Sistema de Monitoreo**

**Meta:** Hacer que el `MonitorSimulacion` (`monitores.py`) pueda registrar no solo el estado diario, sino también los eventos de disrupción que ocurran.

*   **Tarea 4.1: Hacer que el Monitor "Escuche" los Eventos.**
    *   **Qué hacer:** El `MonitorSimulacion` debe ser notificado cada vez que ocurra un evento importante en la simulación.
    *   **Detalle:** Se implementará un sistema de "suscripción". Al iniciar la simulación, le diremos a cada entidad (camiones, nodos, y el gestor de disrupciones) que el `MonitorSimulacion` es un "suscriptor". Cuando una entidad genere un evento (ej. `GestorDisrupciones` activa una "Nevada Intensa"), notificará a todos sus suscriptores.

*   **Tarea 4.2: Ampliar los Datos Registrados.**
    *   **Qué hacer:** Añadir columnas al archivo de salida para registrar las disrupciones.
    *   **Detalle:** La clase `RegistroDiario` en `monitores.py` tendrá nuevos campos como: `disrupcion_activa: bool`, `tipo_disrupcion: str`, `severidad_disrupcion: int`.
    *   **Por qué:** Esto es **esencial** para tu tesis. Te permitirá filtrar los resultados por días en los que hubo una disrupción y comparar directamente los KPIs (como el nivel de servicio) de los días normales contra los días con disrupción, cuantificando así el impacto.