# 📱 Flutter Template

## 📋 Requisitos Mínimos
- Flutter SDK: ^3.7.0
- iOS: 11.0+
- Android: API 21+ (Android 5.0 Lollipop)

## 🏗️ Arquitectura

Este proyecto implementa una arquitectura MVVM (Model-View-ViewModel) con Clean Architecture:

```
lib/
├── config/          # Configuraciones globales
│   ├── navigation/  # Gestión de rutas
│   ├── networking/  # Configuración de red
│   ├── tracking/    # Analíticas (MixPanel)
│   └── translate/   # Internacionalización
├── domain/         # Lógica de negocio
│   ├── entities/   # Modelos de dominio
│   ├── managers/   # Interfaces de gestores
│   └── use_cases/  # Casos de uso
├── infrastructure/ # Implementaciones
│   ├── managers/   # Implementación de gestores
│   ├── models/     # Modelos de datos
│   └── services/   # Servicios de API
└── presentation/   # UI
    ├── base/       # Componentes base
    ├── flows/      # Flujos de la aplicación
    └── widgets/    # Widgets reutilizables
```

## 📦 Librerías Principales

### Gestión de Estado y DI
- **Riverpod**: ^2.5.2 - Gestión de estado e inyección de dependencias
- **Hooks Riverpod**: Para composición de widgets y estado

### Networking y Datos
- **Dio**: ^5.7.0 - Cliente HTTP
- **Retrofit**: ^4.4.1 - Cliente REST type-safe
- **Shared Preferences**: ^2.3.2 - Almacenamiento local
- **Flutter Secure Storage**: Almacenamiento seguro

### UI y Navegación
- **Go Router**: ^14.2.7 - Navegación
- **Flutter SVG**: ^2.0.10 - Soporte SVG
- **Animate Do**: ^4.2.0 - Animaciones
- **Lottie**: ^3.1.2 - Animaciones complejas

### Utilidades
- **Freezed**: ^3.0.0 - Generación de código
- **Easy Localization**: ^3.0.7 - Internacionalización
- **Flutter dotenv**: ^5.1.0 - Variables de entorno
- **MixPanel**: Analytics

## ⚙️ Setup del Proyecto

1. **Clonar el repositorio**
   ```bash
   git clone <url-repositorio>
   cd <nombre-proyecto>
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar variables de entorno**
   - Crear archivos en assets/env/:
     - .env.development
     - .env.staging
     - .env.production
   ```
   API_URL=<url-api>
   MIX_PANEL_KEY=<key>
   ```

4. **Setup iOS**
   ```bash
   cd ios
   pod install
   cd ..
   ```

5. **Generar código**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## 🚀 Flavors y Ambientes

### Ejecutar por ambiente
```bash
# Desarrollo
flutter run --flavor development -t lib/main.dart

# Staging
flutter run --flavor staging -t lib/main.dart

# Producción
flutter run --flavor production -t lib/main.dart
```

## 🛠️ Guía de Desarrollo

### Crear un Nuevo Flujo

1. **Definir el Estado (State)**
   ```dart
   // lib/presentation/flows/example/states/example_state.dart
   @freezed
   class ExampleState with _$ExampleState {
     factory ExampleState({
       @Default([]) List<Item> items,
     }) = _ExampleState;
   }
   ```

2. **Crear el ViewModel**
   ```dart
   // lib/presentation/flows/example/providers/example_provider.dart
   class ExampleProvider extends BaseStateNotifier<ExampleState, ExampleAction> {
     ExampleProvider({required super.ref}) : super(state: ExampleState());
   }
   ```

3. **Implementar la UI**
   ```dart
   // lib/presentation/flows/example/ui/example_screen.dart
   class ExampleScreen extends BaseStatelessScreen {
     @override
     Widget buildView(BuildContext context, WidgetRef ref) {
       return Container();
     }
   }
   ```

4. **Configurar la Navegación**
   - Añadir la ruta en `lib/config/navigation/app_router.dart`

### Manejo de Traducciones

- Archivos en `assets/translations/`
  - en-EN.json
  - es-ES.json
- Uso: `'key'.tr()`

## 🔍 Testing

```bash
# Ejecutar tests
flutter test

# Tests con coverage
flutter test --coverage
```

## 📦 Generación de Build

### Android
```bash
flutter build apk --flavor production -t lib/main.dart
```

### iOS
```bash
flutter build ios --flavor production -t lib/main.dart
```

## 🔐 Seguridad

- Almacenamiento seguro de tokens mediante Flutter Secure Storage
- Encriptación de SharedPreferences en Android
- Configuración de KeychainAccessibility en iOS

## 🎨 Theming

El proyecto utiliza Material 3 con temas personalizados:
- Color Scheme personalizado
- Typography personalizada
- Extensiones de tema para colores y textos personalizados

## 📝 Notas Adicionales

- Mantener actualizadas las dependencias
- Seguir las convenciones de código del proyecto
- Documentar cambios significativos
- Utilizar los providers base para nueva funcionalidad