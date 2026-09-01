import 'package:bx_mobile/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:bx_mobile/features/auth/presentation/provider/auth_notifier.dart';

import 'core/storage/secure_json_storage_service.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user_use_case.dart';
import 'features/auth/domain/usecases/login_demo_use_case.dart';

class AppDependencies {
  late final SecureJsonStorageService secureStorageService;
  late final AuthLocalDataSource authLocalDataSource;
  late final AuthRepository authRepository;
  late final LoginDemoUseCase loginDemoUseCase;
  late final GetCurrentUserUseCase getCurrentUserUseCase;
  late final AuthNotifier authNotifier;

  Future<void> init() async {
    // 1. Core
    secureStorageService = SecureJsonStorageService();
    await secureStorageService.init();

    // 2. Data Sources
    authLocalDataSource = AuthLocalDataSource(
      storageService: secureStorageService,
    );

    // 3. Repositories
    authRepository = AuthRepositoryImpl(localDataSource: authLocalDataSource);

    // 4. Use Cases
    loginDemoUseCase = LoginDemoUseCase(repository: authRepository);
    getCurrentUserUseCase = GetCurrentUserUseCase(repository: authRepository);

    // 5. Presentation / Notifier
    authNotifier = AuthNotifier(
      getCurrentUserUseCase: getCurrentUserUseCase,
      loginDemoUseCase: loginDemoUseCase,
      authRepository: authRepository,
    );
  }
}
