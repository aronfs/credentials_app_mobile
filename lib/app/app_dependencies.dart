import 'package:archive_secure/core/network/auth_interceptor.dart';
import 'package:archive_secure/core/security/biometric_service.dart';
import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/data/auth/data/auth_repository_impl.dart';
import 'package:archive_secure/data/auth/data/source/network/api.dart';
import 'package:archive_secure/data/auth/domain/repository/auth_repository.dart';
import 'package:archive_secure/data/auth/domain/usecase/register.dart';
import 'package:archive_secure/data/auth/domain/usecase/sign_in.dart';
import 'package:archive_secure/data/auth/domain/usecase/verify_pin.dart';
import 'package:archive_secure/data/categories/bloc/category_bloc.dart';
import 'package:archive_secure/data/categories/data/category_repository_impl.dart';
import 'package:archive_secure/data/categories/data/source/network/api.dart';
import 'package:archive_secure/data/categories/domain/usecase/create_category.dart';
import 'package:archive_secure/data/categories/domain/usecase/delete_category.dart';
import 'package:archive_secure/data/categories/domain/usecase/get_categories.dart';
import 'package:archive_secure/data/categories/domain/usecase/update_category.dart';
import 'package:archive_secure/data/credentials/bloc/credential_bloc.dart';
import 'package:archive_secure/data/credentials/data/credential_repository_impl.dart';
import 'package:archive_secure/data/credentials/data/source/network/api.dart';
import 'package:archive_secure/data/credentials/domain/usecase/create_credential.dart';
import 'package:archive_secure/data/credentials/domain/usecase/delete_credential.dart';
import 'package:archive_secure/data/credentials/domain/usecase/get_credential_password.dart';
import 'package:archive_secure/data/credentials/domain/usecase/get_credentials.dart';
import 'package:archive_secure/data/credentials/domain/usecase/search_credentials.dart';
import 'package:archive_secure/data/credentials/domain/usecase/toggle_favorite.dart';
import 'package:archive_secure/data/credentials/domain/usecase/update_credential.dart';
import 'package:archive_secure/data/datasources/dashboard_remote_datasource.dart';
import 'package:archive_secure/data/datasources/favorites_remote_datasource.dart';
import 'package:archive_secure/data/datasources/profile_remote_datasource.dart';
import 'package:archive_secure/data/repositories/dashboard_repository.dart';
import 'package:archive_secure/data/repositories/favorites_repository_impl.dart';
import 'package:archive_secure/data/repositories/profile_repository_impl.dart';
import 'package:archive_secure/domain/usecases/change_password_usecase.dart';
import 'package:archive_secure/domain/usecases/change_pin_usecase.dart';
import 'package:archive_secure/domain/usecases/get_dashboard_usecase.dart';
import 'package:archive_secure/domain/usecases/get_favorite_credentials_usecase.dart';
import 'package:archive_secure/domain/usecases/get_profile_usecase.dart';
import 'package:archive_secure/domain/usecases/toggle_credential_favorite_usecase.dart';
import 'package:archive_secure/domain/usecases/unmark_credential_favorite_usecase.dart';
import 'package:archive_secure/domain/usecases/update_profile_name_usecase.dart';
import 'package:archive_secure/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:archive_secure/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:archive_secure/presentation/profile/bloc/profile_bloc.dart';
import 'package:archive_secure/data/password_generator/bloc/password_generator_cubit.dart';
import 'package:archive_secure/data/password_generator/data/password_generator_service.dart';
import 'package:archive_secure/utils/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppDependencies {
  AppDependencies._({
    required this.tokenStorage,
    required this.authRepository,
    required this.biometricService,
    required this.authBloc,
    required this.categoryBloc,
    required this.credentialBloc,
    required this.dashboardBloc,
    required this.profileBloc,
    required this.favoritesBloc,
    required this.passwordGeneratorCubit,
  });

  final TokenStorage tokenStorage;
  final AuthRepository authRepository;
  final BiometricService biometricService;
  final AuthBloc authBloc;
  final CategoryBloc categoryBloc;
  final CredentialBloc credentialBloc;
  final DashboardBloc dashboardBloc;
  final ProfileBloc profileBloc;
  final FavoritesBloc favoritesBloc;
  final PasswordGeneratorCubit passwordGeneratorCubit;

  factory AppDependencies.create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: const {'Content-Type': 'application/json'},
      ),
    );
    final tokenStorage = TokenStorage(const FlutterSecureStorage());

    final authApi = ApiImpl(dio);
    final authRepository = AuthRepositoryImpl(authApi, tokenStorage);
    final biometricService = BiometricService();
    final authBloc = AuthBloc(
      signIn: SignIn(repository: authRepository),
      verifyPin: VerifyPin(repository: authRepository),
      register: Register(repository: authRepository),
      tokenStorage: tokenStorage,
      authRepository: authRepository,
      biometricService: biometricService,
    );

    dio.interceptors.add(
      AuthInterceptor(
        tokenStorage: tokenStorage,
        dio: dio,
        onSessionExpired: () =>
            authBloc.add(const LogoutSubmitted(preserveBiometricLogin: false)),
      ),
    );

    final categoryBloc = _createCategoryBloc(dio, tokenStorage);
    final credentialBloc = _createCredentialBloc(dio, tokenStorage);
    final dashboardBloc = _createDashboardBloc(dio);
    final profileBloc = _createProfileBloc(dio, tokenStorage, authBloc);
    final favoritesBloc = _createFavoritesBloc(dio);

    return AppDependencies._(
      tokenStorage: tokenStorage,
      authRepository: authRepository,
      biometricService: biometricService,
      authBloc: authBloc,
      categoryBloc: categoryBloc,
      credentialBloc: credentialBloc,
      dashboardBloc: dashboardBloc,
      profileBloc: profileBloc,
      favoritesBloc: favoritesBloc,
      passwordGeneratorCubit: PasswordGeneratorCubit(
        PasswordGeneratorService(dio, tokenStorage),
      ),
    );
  }

  static DashboardBloc _createDashboardBloc(Dio dio) {
    final dataSource = DashboardRemoteDataSourceImpl(dio);
    final repository = DashboardRepositoryImpl(dataSource);
    final useCase = GetDashboardUseCase(repository: repository);
    return DashboardBloc(getDashboardUseCase: useCase);
  }

  static CategoryBloc _createCategoryBloc(Dio dio, TokenStorage tokenStorage) {
    final api = CategoryApiImpl(dio);
    final repository = CategoryRepositoryImpl(api, tokenStorage);

    return CategoryBloc(
      getCategories: GetCategories(repository: repository),
      createCategory: CreateCategory(repository: repository),
      updateCategory: UpdateCategory(repository: repository),
      deleteCategory: DeleteCategory(repository: repository),
    );
  }

  static CredentialBloc _createCredentialBloc(
    Dio dio,
    TokenStorage tokenStorage,
  ) {
    final api = CredentialApiImpl(dio);
    final repository = CredentialRepositoryImpl(api, tokenStorage);

    return CredentialBloc(
      getCredentials: GetCredentials(repository: repository),
      searchCredentials: SearchCredentials(repository: repository),
      createCredential: CreateCredential(repository: repository),
      updateCredential: UpdateCredential(repository: repository),
      toggleFavorite: ToggleFavorite(repository: repository),
      deleteCredential: DeleteCredential(repository: repository),
      getCredentialPassword: GetCredentialPassword(repository: repository),
    );
  }

  static ProfileBloc _createProfileBloc(
    Dio dio,
    TokenStorage tokenStorage,
    AuthBloc authBloc,
  ) {
    final dataSource = ProfileRemoteDataSourceImpl(dio);
    final repository = ProfileRepositoryImpl(dataSource);
    return ProfileBloc(
      getProfileUseCase: GetProfileUseCase(repository: repository),
      updateProfileNameUseCase:
          UpdateProfileNameUseCase(repository: repository),
      changePinUseCase: ChangePinUseCase(repository: repository),
      changePasswordUseCase: ChangePasswordUseCase(repository: repository),
      tokenStorage: tokenStorage,
      onSessionExpired: () =>
          authBloc.add(const LogoutSubmitted(preserveBiometricLogin: false)),
    );
  }

  static FavoritesBloc _createFavoritesBloc(Dio dio) {
    final dataSource = FavoritesRemoteDataSourceImpl(dio);
    final repository = FavoritesRepositoryImpl(dataSource);
    return FavoritesBloc(
      getFavoriteCredentialsUseCase:
          GetFavoriteCredentialsUseCase(repository: repository),
      toggleCredentialFavoriteUseCase:
          ToggleCredentialFavoriteUseCase(repository: repository),
      unmarkCredentialFavoriteUseCase:
          UnmarkCredentialFavoriteUseCase(repository: repository),
    );
  }

  void dispose() {
    authBloc.close();
    categoryBloc.close();
    credentialBloc.close();
    dashboardBloc.close();
    profileBloc.close();
    favoritesBloc.close();
    passwordGeneratorCubit.close();
  }
}
