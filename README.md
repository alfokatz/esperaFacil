# EsperaFácil

## 📱 Descripción

**EsperaFácil** es una aplicación móvil desarrollada en Flutter diseñada para facilitar la gestión de listas de espera en negocios y restaurantes. La aplicación permite a los empleados gestionar eficientemente los grupos de clientes que esperan ser atendidos, brindando una solución integral para controlar el flujo de espera.

## 🎯 Objetivo

El objetivo principal de EsperaFácil es simplificar y optimizar la gestión de listas de espera en establecimientos comerciales, permitiendo:

- **Gestionar grupos de espera** de manera organizada y eficiente
- **Monitorear el tiempo de espera** de cada cliente en tiempo real
- **Notificar a los clientes** cuando estén próximos a ser atendidos
- **Marcar el estado** de cada grupo (en espera, notificado, atendido, cancelado)
- **Mantener información de contacto** (teléfono, notas) para cada grupo
- **Filtrar grupos** según su estado para una mejor organización

## ⚙️ Funcionamiento

La aplicación funciona de la siguiente manera:

### Pantalla de Inicio
- Muestra una lista de grupos de espera activos
- Permite filtrar grupos por estado (Todos, Esperando, Notificados)
- Muestra información resumida: nombre del cliente, número de personas y tiempo de espera
- Al seleccionar un grupo, se navega a su pantalla de detalle

### Pantalla de Detalle
- Muestra información completa del grupo de espera:
  - Nombre e ID del cliente
  - Número de personas
  - Tiempo de espera calculado automáticamente
  - Información de contacto (teléfono, notas)
- Permite realizar acciones sobre el grupo:
  - **Marcar como atendido**: Cambia el estado a "Atendido"
  - **Notificar**: Marca al cliente como notificado
  - **Cancelar**: Cancela el grupo de espera

### Gestión de Estados
Los grupos de espera pueden tener los siguientes estados:
- **Esperando**: Cliente en lista de espera
- **Notificado**: Cliente notificado que será atendido pronto
- **Atendido**: Cliente ya fue atendido
- **Cancelado**: Grupo cancelado

## 🛠️ Tecnologías Utilizadas

- **Flutter** - Framework de desarrollo móvil
- **Supabase** - Backend y base de datos
- **Riverpod** - Gestión de estado
- **GoRouter** - Navegación

## 🚀 Configuración

1. Clonar el repositorio
2. Instalar dependencias: `flutter pub get`
3. Configurar variables de entorno en `assets/env/`:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
   - `MIX_PANEL_KEY`
4. Ejecutar la aplicación: `flutter run`

## 📝 Notas

- La aplicación requiere autenticación para acceder a los grupos de espera
- Los grupos de espera están asociados a un negocio específico
- El tiempo de espera se calcula automáticamente basado en la fecha de creación
