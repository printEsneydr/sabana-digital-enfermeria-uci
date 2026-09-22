# Sábana Digital de Enfermería - UCI - HUDN

Aplicación móvil y web desarrollada en Flutter para la **Unidad de Cuidados Intensivos (UCI)** del **Hospital Universitario Departamental de Nariño (HUDN)**, en Pasto (Colombia). Su objetivo es reemplazar la sábana clínica física de papel que utiliza el personal de enfermería para el registro diario de pacientes críticos, eliminando errores de transcripción y reduciendo el tiempo dedicado al llenado manual de formatos.

---

##  Descripción del proyecto

Esta aplicación permite **registrar, consultar, firmar y exportar** todos los datos clínicos de los pacientes en tiempo real. Fue validada directamente con el personal de enfermería de la UCI del HUDN y cumple con el flujo de trabajo real de los turnos de **mañana, tarde y noche**.

### Tecnologías utilizadas

- **Flutter y Dart** para el desarrollo de la interfaz y la lógica de negocio.
- **Firebase Firestore** como base de datos en la nube.
- **Firebase Authentication** para el control de acceso por roles.
- **Riverpod (hooks_riverpod)** para la gestión del estado de la aplicación.
- **Freezed y json_serializable** para la serialización de modelos de datos.
- **pdf y printing** para la generación e impresión de reportes PDF.
- **signature** para la captura de firmas digitales del personal.

---

##  Funcionalidades principales

Todos los módulos están completamente implementados:

| Módulo | Descripción |
| --- | --- |
| **Registro de pacientes** | Crear, editar y gestionar los ingresos a la UCI con datos personales, diagnósticos y asignación de cama. |
| **Monitoría hemodinámica** | Registro por hora de signos vitales y parámetros (presión arterial, frecuencia cardíaca/respiratoria, temperatura, presión venosa central, gasto cardíaco, resistencias vasculares, saturación de oxígeno, entre otros). El horario cubre desde las 8 a. m. hasta las 7 a. m. del día siguiente. |
| **Balance de líquidos** | Registro de líquidos administrados y eliminados por hora (diuresis, pérdidas insensibles, sondas, drenajes, deposiciones y diálisis). El balance se calcula automáticamente. |
| **Nutrición** | Registro antropométrico con cálculo automático de IMC y requerimiento calórico, más la nutrición administrada por turno con distribución de proteínas, lípidos y carbohidratos. |
| **Escala de Glasgow** | Evaluación neurológica con registro de apertura ocular, respuesta verbal y respuesta motora. El puntaje total se calcula automáticamente. |
| **Control de sedación** | Escala RASS (de -5 a +4) para registrar el nivel de sedación por hora. |
| **Cambio de posición** | Registro de posiciones del paciente por hora para prevenir úlceras por presión. |
| **Catéteres y marcapasos** | Gestión completa de dispositivos médicos con fecha de inserción, tipo, vía, frecuencia y características del sitio. |
| **Sondas y drenes** | Registro de sondas con fecha de inserción, días en uso y región anatómica. |
| **Procedimientos especiales** | Registro con estados de seguimiento (por realizar, realizado, reportado) e infusión de medicamentos. |
| **Antibióticos** | Gestión de tratamientos antibióticos con secciones separadas para manitol y corticoides, marcando los días de administración. |
| **Control de riesgos** | Úlceras por presión (escala Braden), riesgo de caídas (escala Downton), anticoagulación, alergias y aislamiento. |
| **Observaciones extras** | Solicitudes de laboratorio, resultados de cultivos, órdenes de transfusión sanguínea y firmas digitales por turno. |
| **Reporte PDF** | Generación de un documento completo con todos los datos del paciente. Se puede guardar, compartir o imprimir desde el dispositivo. |

---

##  Roles de usuario

La aplicación maneja cinco roles con diferentes niveles de acceso:

- **Administrador:** acceso total a todas las funciones, incluida la gestión y eliminación de registros.
- **Enfermero jefe:** acceso completo de lectura, escritura y edición en todos los módulos.
- **Auxiliar de enfermería:** puede registrar datos en los módulos asignados.
- **Médico:** visualización completa de los datos con capacidad de realizar anotaciones.
- **Nutricionista:** acceso al módulo de nutrición y demás registros complementarios.

El rol de cada usuario se lee desde la colección `roles` de Firestore al iniciar sesión.

---

##  Estructura del proyecto

El código sigue **Clean Architecture** con cuatro capas bien diferenciadas. Cada funcionalidad principal tiene su propio módulo dentro de la carpeta `features`:

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── firebase_options.dart     # Configuración de Firebase (generado por flutterfire)
├── common/                   # Componentes, temas, extensiones, validadores y utilidades
├── constants/                # Constantes globales (intervenciones NIC/NOC)
├── features/                 # Módulos por funcionalidad (Clean Architecture)
│   └── <módulo>/
│       ├── data/             # Repositorios y DTOs (Firestore)
│       ├── domain/           # Modelos de datos (Freezed)
│       └── presentation/     # Pantallas, controladores y widgets
└── pages/                    # Pantallas principales de la aplicación
```

- **Capa de dominio:** modelos de datos definidos con Freezed.
- **Capa de datos:** repositorios que se comunican con Firebase Firestore.
- **Capa de presentación:** pantallas, formularios y controladores de estado.
- **Capa de aplicación:** servicios como el generador de reportes PDF.

---

##  Instalación y configuración

### Requisitos previos

- Flutter SDK (versión 3.x)
- Una cuenta de Firebase y el proyecto de la app vinculado
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli) y Firebase CLI

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/printEsneydr/sabana-digital-enfermeria-uci.git
cd sabana-digital-enfermeria-uci

# 2. Instalar las dependencias
flutter pub get

# 3. Conectar el proyecto de Firebase
firebase login
flutterfire configure --project=<ID_DEL_PROYECTO>

# 4. Ejecutar la aplicación
flutter run
```

> **Nota importante:** el archivo `lib/firebase_options.dart` es generado automáticamente por `flutterfire configure` y **no se sube al repositorio** (está en `.gitignore` para no exponer las credenciales de Firebase). Sin este paso la aplicación no podrá inicializar Firebase.

### Versión de producción

```bash
# APK para Android
flutter build apk --release

# Versión web y despliegue en Firebase Hosting
flutter build web --release
firebase deploy --only hosting
```

---

##  Estado del proyecto

La aplicación se encuentra **completamente funcional**, con todos los módulos implementados y validados con el personal de la UCI del Hospital Universitario Departamental de Nariño. Incluye más de 4500 líneas de código, 10 pantallas principales, 18 módulos funcionales y documentación técnica (manual de usuario y guía de migración de Firebase).

---

##  Créditos

- **Autor principal: Esneyder Jesús Ibarra Rosero** — Ingeniero de Sistemas (práctica profesional). Responsable del desarrollo, integración con Firebase y generación de reportes PDF.
- **Carlos Botina** — Universidad Mariana (colaborador inicial).
- **Jhon Tajumbina** — Universidad Mariana (colaborador inicial).

Este proyecto hace parte del ejercicio de práctica profesional en ingeniería de sistemas y fue desarrollado en coordinación con el área de sistemas del hospital.

---

##  Contacto

Para soporte o consultas técnicas, contactar a **Esneyder Jesús Ibarra Rosero**:

- **Teléfono:** +57 323 215 7962
- **Correo:** esneydribarra1970@gmail.com
- **LinkedIn:** [esneyder-ibarra-rosero](https://www.linkedin.com/in/esneyder-ibarra-rosero)
- **GitHub:** [printEsneydr](https://github.com/printEsneydr)

---

##  Migración de Firebase

Si necesitas migrar la base de datos a un nuevo proyecto de Firebase (cambiar de cuenta, hospital o entorno), consulta el documento incluido: **"README - Migración Firebase"**. Explica paso a paso cómo crear el proyecto, configurar Firestore, crear los usuarios con roles y conectar la aplicación.
