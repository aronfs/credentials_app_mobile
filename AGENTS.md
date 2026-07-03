# AGENTS.md — Flutter/Dart

## Proyecto
Aplicación Flutter: **Archivero Seguro**.

Objetivo: construir una app móvil para guardar emails, usuarios y contraseñas de forma segura, consumiendo un backend con MongoDB + Prisma ORM + Arquitectura Hexagonal + Bun/TypeScript.

La app debe respetar el diseño visual de referencia:
- Fondo oscuro con patrón punteado.
- Tarjetas claras con bordes redondeados.
- Paleta principal:
  - Primary: `#0F172A`
  - Secondary: `#3B82F6`
  - Tertiary: `#1E293B`
  - Neutral: `#F8FAFC`
- UI limpia, profesional y minimalista.
- Soporte completo para modo claro y oscuro.

---

## Stack Flutter

Usar:
- Flutter estable
- Dart
- Material 3
- flutter_bloc
- equatable
- go_router o Navigator 2.0
- dio
- flutter_secure_storage
- local_auth
- intl
- flutter_localizations
- l10n configurado con Flutter gen-l10n

No usar lógica de negocio directamente dentro de widgets.

---

## Internacionalización obligatoria

La app ya usa l10n Flutter.

Mantener y respetar la configuración:

```yaml
flutter:
  generate: true
```

Archivos esperados:

```txt
lib/l10n/app_en.arb
lib/l10n/app_es.arb
```

Todas las pantallas, botones, labels, validaciones, errores y mensajes deben usar:

```dart
AppLocalizations.of(context)!
```

No escribir textos quemados directamente en widgets.

Incorrecto:

```dart
Text('Crear credencial')
```

Correcto:

```dart
Text(loc.createCredential)
```

Agregar claves faltantes en:

```txt
app_es.arb
app_en.arb
```

Ejemplos de claves necesarias:

```json
{
  "appName": "Archivero Seguro",
  "login": "Iniciar sesión",
  "email": "Correo electrónico",
  "password": "Contraseña",
  "createCredential": "Crear credencial",
  "editCredential": "Editar credencial",
  "deleteCredential": "Eliminar credencial",
  "viewPassword": "Ver contraseña",
  "copyPassword": "Copiar contraseña",
  "serviceName": "Nombre del servicio",
  "username": "Usuario",
  "category": "Categoría",
  "notes": "Notas",
  "favorites": "Favoritos",
  "search": "Buscar",
  "settings": "Configuración",
  "logout": "Cerrar sesión",
  "requiredField": "Campo obligatorio",
  "invalidEmail": "Correo inválido"
}
```

También agregar su equivalente en inglés.

Después de modificar los `.arb`, ejecutar:

```bash
flutter gen-l10n
flutter pub get
```

---

## Arquitectura Flutter recomendada

Usar arquitectura limpia en Flutter:

```txt
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── security/
│   ├── theme/
│   ├── router/
│   └── utils/
│
├── l10n/
│   ├── app_en.arb
│   └── app_es.arb
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── credentials/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── categories/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── users/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── settings/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

Cada feature debe tener:

```txt
data/
- models
- datasources
- repositories implementation

domain/
- entities
- repositories abstractos
- usecases

presentation/
- bloc/cubit
- pages
- widgets
```

---

## Módulos de la app

Implementar pantallas para:

### Auth
- Login
- Registro
- Verificación de PIN
- Biometría opcional
- Logout
- Refresh token automático

### Credentials
- Listar credenciales
- Crear credencial
- Editar credencial
- Eliminar credencial
- Buscar por servicio, email, usuario o tags
- Filtrar por categoría
- Marcar favorito
- Ver contraseña mediante endpoint seguro

Endpoint para ver contraseña:

```txt
GET /api/credentials/:id/password
```

Reglas UI:
- La contraseña siempre debe aparecer oculta por defecto.
- Solo mostrarla cuando el usuario presione “Ver contraseña”.
- Solicitar biometría o PIN antes de mostrarla si está configurado.
- Copiar contraseña al portapapeles.
- Limpiar portapapeles después de unos segundos.

### Categories
- Listar categorías
- Crear categoría
- Editar categoría
- Eliminar categoría

Categorías iniciales sugeridas:
- Personal
- Trabajo
- Bancos
- Redes Sociales
- Estudios

### Users y Roles
- Solo visible para ADMIN.
- Listar usuarios.
- Crear usuario.
- Editar usuario.
- Asignar rol.
- Listar roles.

### Security Logs
- Solo visible para ADMIN.
- Mostrar eventos como:
  - LOGIN
  - LOGOUT
  - CREATE_CREDENTIAL
  - UPDATE_CREDENTIAL
  - DELETE_CREDENTIAL
  - VIEW_PASSWORD

---

## Seguridad en Flutter

Usar `flutter_secure_storage` para guardar:
- accessToken
- refreshToken
- userId
- role
- permisos

No guardar contraseñas reales en SharedPreferences.
No guardar contraseñas descifradas en estado persistente.
No imprimir tokens ni contraseñas en consola.

Cuando la app pase a background:
- Bloquear sesión visualmente.
- Pedir PIN o biometría al volver.

---

## Diseño UI/UX

Crear tema centralizado:

```txt
lib/core/theme/
├── app_colors.dart
├── app_text_styles.dart
├── app_theme.dart
└── app_spacing.dart
```

Colores base:

```dart
class AppColors {
  static const primary = Color(0xFF0F172A);
  static const secondary = Color(0xFF3B82F6);
  static const tertiary = Color(0xFF1E293B);
  static const neutral = Color(0xFFF8FAFC);
}
```

Usar Material 3:

```dart
ThemeData(
  useMaterial3: true,
)
```

Componentes requeridos:
- AppBar limpia.
- Cards redondeadas.
- Inputs con borde suave.
- Botones primary, secondary, inverted y outlined.
- Bottom navigation con Home, Search, Profile.
- Íconos consistentes.
- Estados vacíos profesionales.
- Loading skeleton o CircularProgressIndicator.
- Mensajes de error localizados.

---

## Reglas de código

- No crear widgets gigantes.
- Separar widgets reutilizables.
- No usar `setState` para lógica compleja.
- Usar Bloc/Cubit por feature.
- Manejar estados: initial, loading, success, empty, error.
- Validar formularios.
- Usar DTOs/models para requests y responses.
- Manejar errores de Dio con clases propias.
- Mantener nombres claros en inglés para código.
- Mantener textos visibles traducidos con l10n.

---

## API esperada

Base URL configurable:

```dart
const baseUrl = String.fromEnvironment('API_BASE_URL');
```

Endpoints principales:

```txt
POST /api/auth/register
POST /api/auth/login
POST /api/auth/refresh
POST /api/auth/logout
POST /api/auth/verify-pin

GET /api/credentials
POST /api/credentials
GET /api/credentials/:id
GET /api/credentials/:id/password
PUT /api/credentials/:id
PATCH /api/credentials/:id/favorite
DELETE /api/credentials/:id
GET /api/credentials/search?q=

GET /api/categories
POST /api/categories
PUT /api/categories/:id
DELETE /api/categories/:id

GET /api/users
POST /api/users
PUT /api/users/:id
DELETE /api/users/:id

GET /api/roles
POST /api/roles
PUT /api/roles/:id
DELETE /api/roles/:id

GET /api/security-logs
```

---

## Resultado esperado

La IA debe generar o modificar el proyecto Flutter respetando:
- Diseño de Archivero Seguro.
- l10n español/inglés.
- Arquitectura limpia por features.
- Bloc/Cubit.
- Consumo correcto de API.
- Seguridad con tokens, PIN y biometría.
- Tema centralizado con Material 3.
- Código mantenible y escalable.
