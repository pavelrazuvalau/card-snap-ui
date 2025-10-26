# Adaptive Widgets Module

## Purpose

This module provides **cross-platform adaptive UI components** that automatically adjust their appearance and behavior based on the current platform (Android Material, iOS Cupertino, Web).

## Angular Analogy

Similar to Angular's platform detection and component adaptation:
- **Platform Detection Service** → `PlatformDetector.getCurrentTheme()`
- **Component Factory Pattern** → `AdaptiveWidgetFactory`
- **Platform-specific Templates** → Different UI based on platform

## Architecture

```
adaptive/
├── common/
│   └── platform_types.dart          # Shared types and platform detection
├── scaffold/
│   └── adaptive_scaffold_factory.dart  # Adaptive page scaffold factory
├── card/
│   └── adaptive_card_factory.dart      # Adaptive card factory
├── button/
│   └── adaptive_button_factory.dart    # Adaptive button factory
└── adaptive_widget_module.dart         # Main facade exporting all factories
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
),
);
```

## Usage Pattern

**DO** - Use adaptive widgets in your app widgets:
```dart
// lib/presentation/widgets/card_tile.dart
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

When adding a new adaptive widget type:

1. Create a new folder (e.g., `dialog/`)
2. Create the interface file (e.g., `dialog_strategy_interface.dart`)
3. Create Material implementation (e.g., `material_dialog_strategy.dart`)
4. Create Cupertino implementation (e.g., `cupertino_dialog_strategy.dart`)
5. Create strategy factory (e.g., `dialog_strategy_factory.dart`)
6. Create adaptive factory (e.g., `adaptive_dialog_factory.dart`)
7. Export from `adaptive_widget_module.dart`
8. Add convenience method to `AdaptiveWidgetFactory`

Example:
```dart
// lib/presentation/widgets/adaptive/dialog/dialog_strategy_interface.dart
abstract class DialogStrategy {
  Widget createDialog({required String title});
}

// lib/presentation/widgets/adaptive/dialog/material_dialog_strategy.dart
class MaterialDialogStrategy implements DialogStrategy {
  @override
  Widget createDialog({required String title}) {
    return AlertDialog(title: Text(title));
  }
}

// lib/presentation/widgets/adaptive/dialog/cupertino_dialog_strategy.dart
class CupertinoDialogStrategy implements DialogStrategy {
  @override
  Widget createDialog({required String title}) {
    return CupertinoAlertDialog(title: Text(title));
  }
}

// lib/presentation/widgets/adaptive/dialog/dialog_strategy_factory.dart
class DialogStrategyFactory {
  static DialogStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoDialogStrategy(),
      () => MaterialDialogStrategy(),
    );
  }
}

// lib/presentation/widgets/adaptive/dialog/adaptive_dialog_factory.dart
class AdaptiveDialogFactory {
  static Widget createDialog({required String title}) {
    final theme = PlatformDetector.getCurrentTheme();
    final strategy = DialogStrategyFactory.getStrategy(theme);
    return strategy.createDialog(title: title);
  }
}
```

## Benefits

1. **Consistency** - UI adapts automatically to platform conventions
2. **Maintainability** - Platform-specific logic centralized in one place
3. **Reusability** - Write once, works everywhere
4. **Type Safety** - Platform detection is type-safe and predictable
5. **Future-proof** - Easy to add new platforms or modify existing ones