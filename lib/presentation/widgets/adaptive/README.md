# Adaptive Widgets Module

## Purpose

This module provides **cross-platform adaptive UI components** that automatically adjust their appearance and behavior based on the current platform (Android Material, iOS Cupertino, Web).

## Angular Analogy

Similar to Angular's platform detection and component adaptation:
- **Platform Detection Service** → `PlatformDetector.getCurrentTheme()`
- **Component Factory Pattern** → `AdaptiveWidgetFactory` with helper methods
- **Platform-specific Templates** → Material/Cupertino strategies
- **Strategy Pattern** → Platform-specific implementations encapsulated

## Architecture

```
adaptive/
├── common/
│   ├── platform_types.dart          # Shared types and platform detection
│   └── strategy_selector.dart        # Centralized platform selection
├── scaffold/                         # Platform-specific strategies
│   ├── scaffold_strategy_interface.dart
│   ├── material_scaffold_strategy.dart
│   ├── cupertino_scaffold_strategy.dart
│   ├── scaffold_strategy_factory.dart
│   └── adaptive_scaffold_factory.dart
├── card/
├── button/
├── app_bar/
├── list_tile/
├── progress_indicator/
├── dialog/
└── adaptive_widget_module.dart       # Main facade with helper methods
```

## Key Components

### PlatformDetector
Centralized platform detection utility.
```dart
final theme = PlatformDetector.getCurrentTheme();
// Returns: PlatformTheme.material, .cupertino, or .web
```

### AdaptiveWidgetFactory
Main facade providing convenient access to all adaptive widgets.

```dart
// Create platform-appropriate scaffold
AdaptiveWidgetFactory.createScaffold(
  body: MyContent(),
  appBar: AdaptiveWidgetFactory.createAppBar(title: "My Page"),
);

// Create platform-appropriate card
AdaptiveWidgetFactory.createCard(
  child: MyContent(),
);

// Create platform-appropriate button
AdaptiveWidgetFactory.createButton(
  child: Text("Click me"),
  onPressed: () {},
);
```

## Usage Pattern

**DO** - Use adaptive widgets in your app widgets:
```dart
// lib/presentation/widgets/card_tile.dart
import 'adaptive/adaptive_widget_module.dart';

class CardTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveWidgetFactory.createCard(
      child: CardContent(),
    );
  }
}
```

**DON'T** - Put domain-specific widgets in the `adaptive/` folder:
- `adaptive/` is for reusable UI infrastructure (factories, utilities)
- Domain widgets (like `CardTile`) should be in `presentation/widgets/`

## Adding New Adaptive Widgets

When adding a new adaptive widget type (e.g., Switch):

1. **Create a new folder** (e.g., `switch/`)
2. **Create strategy interface** (`switch_strategy_interface.dart`)
3. **Create Material implementation** (`material_switch_strategy.dart`)
4. **Create Cupertino implementation** (`cupertino_switch_strategy.dart`)
5. **Create strategy factory** (`switch_strategy_factory.dart`)
6. **Create adaptive factory** (`adaptive_switch_factory.dart`)
7. **Add helper method** to `AdaptiveWidgetFactory`:
   ```dart
   static Widget createSwitch({
     required bool value,
     required ValueChanged<bool> onChanged,
   }) {
     return AdaptiveSwitchFactory.createSwitch(
       value: value,
       onChanged: onChanged,
     );
   }
   ```
8. **Export from module** in `adaptive_widget_module.dart`

## Benefits

1. **Consistency** - UI adapts automatically to platform conventions
2. **Maintainability** - Platform-specific logic centralized in one place
3. **Reusability** - Write once, works everywhere
4. **Type Safety** - Platform detection is type-safe and predictable
5. **Future-proof** - Easy to add new platforms or modify existing ones

## Flutter vs Angular

This implementation uses **Flutter-idiomatic** Factory + Strategy pattern:

**Flutter approach:**
- Direct factory methods: `AdaptiveWidgetFactory.createX()`
- Strategy pattern for platform-specific implementations
- Simple, clean, easy to understand

**Angular concepts (educational):**
- Factory Pattern (Angular: component factory)
- Platform Detection (Angular: platform detection service)
- Strategy Pattern (Angular: platform-specific templates)

**Key difference:** In Flutter, we don't need dependency injection - we use factory methods directly. Angular concepts are used here only for **educational purposes** to help Angular developers understand Flutter patterns.
