import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/favorites/favorites_page.dart';
import 'package:archive_secure/presentation/home/home_screen.dart';
import 'package:archive_secure/presentation/modals/form_category.dart';
import 'package:archive_secure/presentation/modals/form_credential.dart';
import 'package:archive_secure/presentation/profile/profile_page.dart';
import 'package:archive_secure/presentation/screens/pin_entry_page.dart';
import 'package:archive_secure/presentation/screens/security_page.dart';
import 'package:archive_secure/presentation/session/sign_in_page.dart';
import 'package:archive_secure/presentation/session/sign_up_page.dart';
import 'package:archive_secure/presentation/splash/splas_page.dart';
import 'package:archive_secure/presentation/welcome/firts_page.dart';
import 'package:archive_secure/presentation/welcome/second_page.dart';
import 'package:archive_secure/presentation/welcome/third_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (ctx) => SplasPage(
            onComplete: () =>
                Navigator.pushReplacementNamed(ctx, welcomePage),
          ),
        );
      case welcomePage:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => const WelcomePage(),
        );
      case secondPage:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => const SecondPage(),
        );
      case thirdPage:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => const ThirdPage(),
        );
      case signInPage:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => SignInPage(),
        );
      case signUpPage:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => const SignUpPage(),
        );
      case pinEntryPage:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => const PinEntryPage(),
        );
      case homePage:
        return MaterialPageRoute(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => const HomeScreen(),
        );
      case categoryFormPage:
        final category = settings.arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FormCategory(category: category as dynamic),
        );
      case credentialFormPage:
        final credential = settings.arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FormCredential(credential: credential as dynamic),
        );
      case securityPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SecurityPage(),
        );
      case credentialDetailPage:
        final credentialId = settings.arguments as String?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => _buildDetailPlaceholder(
            'Detalle de credencial',
            'TODO: Implementar pantalla de detalle para credencial $credentialId',
          ),
        );
      case categoryDetailPage:
        final categoryId = settings.arguments as String?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => _buildDetailPlaceholder(
            'Detalle de categoría',
            'TODO: Implementar pantalla de detalle para categoría $categoryId',
          ),
        );
      case favoritesPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const FavoritesPage(),
        );
      case profilePage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProfilePage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Widget _buildDetailPlaceholder(String title, String message) {
    return Builder(
      builder: (context) {
        final cs = Theme.of(context).colorScheme;
        return Scaffold(
          appBar: AppBar(title: Text(title), centerTitle: true),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.construction_rounded,
                      size: 64, color: cs.onSurfaceVariant),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        final loc = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(title: Text(loc.routeErrorTitle), centerTitle: true),
          body: Center(
            child: Text(
              loc.routeErrorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 18.0),
            ),
          ),
        );
      },
    );
  }
}
