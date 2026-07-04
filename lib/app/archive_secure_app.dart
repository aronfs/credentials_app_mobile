import 'package:archive_secure/app/app_dependencies.dart';
import 'package:archive_secure/core/security/biometric_service.dart';
import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/core/services/app_lock_service.dart';
import 'package:archive_secure/core/services/biometric_auth_service.dart';
import 'package:archive_secure/core/services/biometric_preferences_service.dart';
import 'package:archive_secure/core/theme/theme_mode_controller.dart';
import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_state.dart';
import 'package:archive_secure/data/auth/domain/repository/auth_repository.dart';
import 'package:archive_secure/data/categories/bloc/category_bloc.dart';
import 'package:archive_secure/data/credentials/bloc/credential_bloc.dart';
import 'package:archive_secure/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:archive_secure/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:archive_secure/presentation/profile/bloc/profile_bloc.dart';
import 'package:archive_secure/data/password_generator/bloc/password_generator_cubit.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/navigation_app.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/ui.theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArchiveSecureApp extends StatefulWidget {
  const ArchiveSecureApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  State<ArchiveSecureApp> createState() => _ArchiveSecureAppState();
}

class _ArchiveSecureAppState extends State<ArchiveSecureApp>
    with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var _lockOnResume = false;
  var _navigatingToLock = false;

  AppDependencies get _dependencies => widget.dependencies;
  AppLockService get _appLockService => AppLockService.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _dependencies.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      if (_appLockService.isBiometricUnlockInProgress) {
        _lockOnResume = false;
        return;
      }
      _appLockService.setLocked();
      _markLockRequired();
      return;
    }

    if (state == AppLifecycleState.resumed &&
        _appLockService.shouldBypassLockScreen) {
      _lockOnResume = false;
      return;
    }

    if (state == AppLifecycleState.resumed && _lockOnResume) {
      _showLockScreen();
    }
  }

  Future<void> _markLockRequired() async {
    try {
      _lockOnResume = await _dependencies.tokenStorage.isLoggedIn().timeout(
        const Duration(seconds: 2),
        onTimeout: () => false,
      );
    } catch (_) {
      _lockOnResume = false;
    }
  }

  Future<void> _showLockScreen() async {
    if (_navigatingToLock || _appLockService.shouldBypassLockScreen) return;
    _navigatingToLock = true;
    final isLoggedIn = await _isSessionAvailable();
    if (!mounted || !isLoggedIn || _appLockService.shouldBypassLockScreen) {
      _navigatingToLock = false;
      return;
    }

    _lockOnResume = false;
    _appLockService.setLocked();
    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
      pinEntryPage,
      (route) => false,
    );
    _navigatingToLock = false;
  }

  Future<bool> _isSessionAvailable() async {
    try {
      return await _dependencies.tokenStorage.isLoggedIn().timeout(
        const Duration(seconds: 2),
        onTimeout: () => false,
      );
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, currentMode, _) {
            return _AppProviders(
              dependencies: _dependencies,
              child: _AppShell(
                navigatorKey: _navigatorKey,
                themeMode: currentMode,
              ),
            );
          },
        );
      },
    );
  }
}

class _AppProviders extends StatelessWidget {
  const _AppProviders({required this.dependencies, required this.child});

  final AppDependencies dependencies;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TokenStorage>.value(
          value: dependencies.tokenStorage,
        ),
        RepositoryProvider<AuthRepository>.value(
          value: dependencies.authRepository,
        ),
        RepositoryProvider<BiometricService>.value(
          value: dependencies.biometricService,
        ),
        RepositoryProvider<BiometricAuthService>.value(
          value: dependencies.biometricAuthService,
        ),
        RepositoryProvider<BiometricPreferencesService>.value(
          value: dependencies.biometricPreferencesService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: dependencies.authBloc),
          BlocProvider<CategoryBloc>.value(value: dependencies.categoryBloc),
          BlocProvider<CredentialBloc>.value(
            value: dependencies.credentialBloc,
          ),
          BlocProvider<DashboardBloc>.value(value: dependencies.dashboardBloc),
          BlocProvider<ProfileBloc>.value(value: dependencies.profileBloc),
          BlocProvider<FavoritesBloc>.value(value: dependencies.favoritesBloc),
          BlocProvider<PasswordGeneratorCubit>.value(
            value: dependencies.passwordGeneratorCubit,
          ),
        ],
        child: child,
      ),
    );
  }
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigatorKey, required this.themeMode});

  final GlobalKey<NavigatorState> navigatorKey;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (_, current) => current is Unauthenticated,
      listener: (context, _) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          signInPage,
          (route) => false,
        );
      },
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: splash,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateRoute: RouteGenerator.generateRoute,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: themeMode,
      ),
    );
  }
}
