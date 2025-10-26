/// 🔶 Dependency Injection Container
///
/// Service locator for dependency injection using get_it.
/// Similar to Angular's module providers: register services in one place.
///
/// In Angular, you'd have:
/// ```typescript
/// @NgModule({
///   providers: [
///     { provide: CardRepository, useClass: LocalCardRepository },
///     { provide: AddCard, useClass: AddCardUseCase }
///   ]
/// })
/// ```
///
/// In Flutter/Dart, we use get_it for dependency injection.
import 'package:get_it/get_it.dart';
import '../../data/datasources/local_card_datasource.dart';
import '../../data/repositories/local_card_repository.dart';

/// 🔶 Service locator singleton
/// 🔹 Global DI container
/// 🧠 Similar to Angular's injector
final GetIt serviceLocator = GetIt.instance;

/// Initialize dependency injection
/// 🔹 Register all services and repositories
/// 🧠 Called at app startup (similar to Angular module initialization)
Future<void> initializeDependencyInjection() async {
  // Initialize data sources
  final localDataSource = LocalCardDataSource();
  await localDataSource.initialize();

  // Register repositories
  serviceLocator.registerLazySingleton<LocalCardDataSource>(
    () => localDataSource,
  );

  serviceLocator.registerLazySingleton<LocalCardRepository>(
    () => LocalCardRepository(serviceLocator<LocalCardDataSource>()),
  );

  // TODO: Add more services as needed:
  // - Use cases (AddCard, DeleteCard, etc.)
  // - BLoCs (CardListBloc, etc.)
  // - Services (LoggerService, EncryptionService, etc.)
}
