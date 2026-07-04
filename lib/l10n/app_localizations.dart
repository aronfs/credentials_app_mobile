import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Archivero Seguro'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Save your accounts'**
  String get welcome;

  /// No description provided for @paragraph.
  ///
  /// In en, this message translates to:
  /// **'Save secure form your emails, username, and password with vaulth digital'**
  String get paragraph;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'skip'**
  String get skip;

  /// No description provided for @titleSecondPage.
  ///
  /// In en, this message translates to:
  /// **'Firts Secure'**
  String get titleSecondPage;

  /// No description provided for @paragraphSecondPage.
  ///
  /// In en, this message translates to:
  /// **'Yours data is protected with encriptated of military grade. Only you we have access with PIN or autentication Biometric'**
  String get paragraphSecondPage;

  /// No description provided for @onboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Encriptation AES-256'**
  String get onboardTitle;

  /// No description provided for @onboardParagraph.
  ///
  /// In en, this message translates to:
  /// **'Cifrate unbreakeable'**
  String get onboardParagraph;

  /// No description provided for @onboardTitleSecond.
  ///
  /// In en, this message translates to:
  /// **'Biometric Intregate'**
  String get onboardTitleSecond;

  /// No description provided for @onboardParagraphSecond.
  ///
  /// In en, this message translates to:
  /// **'Fast Access with Face Id or biometric security'**
  String get onboardParagraphSecond;

  /// No description provided for @onboardTitleThird.
  ///
  /// In en, this message translates to:
  /// **'Fast Access'**
  String get onboardTitleThird;

  /// No description provided for @onboardParagraphThird.
  ///
  /// In en, this message translates to:
  /// **'Your Found Information personal Instant, organize your credentails with tags, favorite brand and high searching secure'**
  String get onboardParagraphThird;

  /// No description provided for @labelThird.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get labelThird;

  /// No description provided for @secondlabelThird.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get secondlabelThird;

  /// No description provided for @btnBacklabel.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get btnBacklabel;

  /// No description provided for @btnBeginlabel.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get btnBeginlabel;

  /// No description provided for @titleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Vaulth Secure'**
  String get titleSignIn;

  /// No description provided for @descriptionSignIn.
  ///
  /// In en, this message translates to:
  /// **'Secure access with vaulth digital.'**
  String get descriptionSignIn;

  /// No description provided for @labelSignIn.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelSignIn;

  /// No description provided for @hintSignIn.
  ///
  /// In en, this message translates to:
  /// **'user@example.com'**
  String get hintSignIn;

  /// No description provided for @labelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelPassword;

  /// No description provided for @btnSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get btnSignIn;

  /// No description provided for @btnBiometry.
  ///
  /// In en, this message translates to:
  /// **'Use Biometric'**
  String get btnBiometry;

  /// No description provided for @textSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get textSignIn;

  /// No description provided for @textPasword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password'**
  String get textPasword;

  /// No description provided for @footerSignIn.
  ///
  /// In en, this message translates to:
  /// **'Cifrate side by side.'**
  String get footerSignIn;

  /// No description provided for @divider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get divider;

  /// No description provided for @pinEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your master PIN'**
  String get pinEntryTitle;

  /// No description provided for @pinEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'To access Archivero Seguro'**
  String get pinEntrySubtitle;

  /// No description provided for @useFaceId.
  ///
  /// In en, this message translates to:
  /// **'Use advanced biometrics'**
  String get useFaceId;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your data to secure your access.'**
  String get signUpSubtitle;

  /// No description provided for @signUpNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get signUpNameLabel;

  /// No description provided for @signUpNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. John Doe'**
  String get signUpNameHint;

  /// No description provided for @signUpEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signUpEmailLabel;

  /// No description provided for @signUpEmailHint.
  ///
  /// In en, this message translates to:
  /// **'email@example.com'**
  String get signUpEmailHint;

  /// No description provided for @signUpPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signUpPasswordLabel;

  /// No description provided for @signUpPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get signUpPasswordHint;

  /// No description provided for @signUpConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get signUpConfirmLabel;

  /// No description provided for @signUpConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat your password'**
  String get signUpConfirmHint;

  /// No description provided for @signUpPinLabel.
  ///
  /// In en, this message translates to:
  /// **'Security PIN (4 digits)'**
  String get signUpPinLabel;

  /// No description provided for @signUpPinHint.
  ///
  /// In en, this message translates to:
  /// **'Required for critical actions'**
  String get signUpPinHint;

  /// No description provided for @signUpCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signUpCreateButton;

  /// No description provided for @signUpAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account >'**
  String get signUpAlreadyHaveAccount;

  /// No description provided for @weak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get weak;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @strong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get strong;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'dashboard'**
  String get navDashboard;

  /// No description provided for @navCredential.
  ///
  /// In en, this message translates to:
  /// **'Credential'**
  String get navCredential;

  /// No description provided for @navCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get navCategory;

  /// No description provided for @navGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get navGenerate;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get requiredField;

  /// No description provided for @loginErrorCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get loginErrorCredentials;

  /// No description provided for @loginErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not connect to the server'**
  String get loginErrorNetwork;

  /// No description provided for @loginErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginErrorGeneric;

  /// No description provided for @loginLoading.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get loginLoading;

  /// No description provided for @routeErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get routeErrorTitle;

  /// No description provided for @routeErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The requested screen was not found'**
  String get routeErrorMessage;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @categoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Organize your credentials securely.'**
  String get categoriesSubtitle;

  /// No description provided for @categoriesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No categories yet'**
  String get categoriesEmpty;

  /// No description provided for @categoryCreate.
  ///
  /// In en, this message translates to:
  /// **'Create category'**
  String get categoryCreate;

  /// No description provided for @categoryEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get categoryEdit;

  /// No description provided for @categoryDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete category'**
  String get categoryDelete;

  /// No description provided for @categoryDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get categoryDeleteConfirm;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get categoryName;

  /// No description provided for @categoryNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Social Media'**
  String get categoryNameHint;

  /// No description provided for @categoryColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get categoryColor;

  /// No description provided for @categoryIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get categoryIcon;

  /// No description provided for @categorySave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get categorySave;

  /// No description provided for @categoryCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get categoryCancel;

  /// No description provided for @categoryCreated.
  ///
  /// In en, this message translates to:
  /// **'Category created successfully'**
  String get categoryCreated;

  /// No description provided for @categoryUpdated.
  ///
  /// In en, this message translates to:
  /// **'Category updated successfully'**
  String get categoryUpdated;

  /// No description provided for @categoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Category deleted successfully'**
  String get categoryDeleted;

  /// No description provided for @credentialCreate.
  ///
  /// In en, this message translates to:
  /// **'Create credential'**
  String get credentialCreate;

  /// No description provided for @credentialEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit credential'**
  String get credentialEdit;

  /// No description provided for @credentialDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete credential'**
  String get credentialDelete;

  /// No description provided for @credentialDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this credential?'**
  String get credentialDeleteConfirm;

  /// No description provided for @credentialServiceName.
  ///
  /// In en, this message translates to:
  /// **'Service name'**
  String get credentialServiceName;

  /// No description provided for @credentialServiceNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Gmail'**
  String get credentialServiceNameHint;

  /// No description provided for @credentialLoginEmail.
  ///
  /// In en, this message translates to:
  /// **'Login email'**
  String get credentialLoginEmail;

  /// No description provided for @credentialLoginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'user@example.com'**
  String get credentialLoginEmailHint;

  /// No description provided for @credentialUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get credentialUsername;

  /// No description provided for @credentialUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get credentialUsernameHint;

  /// No description provided for @credentialPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get credentialPassword;

  /// No description provided for @credentialPasswordKeepHint.
  ///
  /// In en, this message translates to:
  /// **'Password (leave empty to keep current)'**
  String get credentialPasswordKeepHint;

  /// No description provided for @credentialPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'No spaces'**
  String get credentialPasswordHint;

  /// No description provided for @credentialCategory.
  ///
  /// In en, this message translates to:
  /// **'Category (optional)'**
  String get credentialCategory;

  /// No description provided for @credentialNoCategory.
  ///
  /// In en, this message translates to:
  /// **'No category'**
  String get credentialNoCategory;

  /// No description provided for @credentialNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get credentialNotes;

  /// No description provided for @credentialNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Additional notes...'**
  String get credentialNotesHint;

  /// No description provided for @credentialTags.
  ///
  /// In en, this message translates to:
  /// **'Tags (optional)'**
  String get credentialTags;

  /// No description provided for @credentialTagsHint.
  ///
  /// In en, this message translates to:
  /// **'Separated by commas: work, important'**
  String get credentialTagsHint;

  /// No description provided for @credentialSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get credentialSave;

  /// No description provided for @credentialCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get credentialCancel;

  /// No description provided for @credentialCreated.
  ///
  /// In en, this message translates to:
  /// **'Credential created successfully'**
  String get credentialCreated;

  /// No description provided for @credentialUpdated.
  ///
  /// In en, this message translates to:
  /// **'Credential updated successfully'**
  String get credentialUpdated;

  /// No description provided for @credentialDeleted.
  ///
  /// In en, this message translates to:
  /// **'Credential deleted successfully'**
  String get credentialDeleted;

  /// No description provided for @credentialViewPassword.
  ///
  /// In en, this message translates to:
  /// **'View password'**
  String get credentialViewPassword;

  /// No description provided for @credentialCopyPassword.
  ///
  /// In en, this message translates to:
  /// **'Copy password'**
  String get credentialCopyPassword;

  /// No description provided for @credentialSearch.
  ///
  /// In en, this message translates to:
  /// **'Search credentials, notes, banks...'**
  String get credentialSearch;

  /// No description provided for @credentialNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get credentialNoResults;

  /// No description provided for @credentialEmpty.
  ///
  /// In en, this message translates to:
  /// **'No credentials yet'**
  String get credentialEmpty;

  /// No description provided for @biometricLoginReason.
  ///
  /// In en, this message translates to:
  /// **'Use your fingerprint to sign in'**
  String get biometricLoginReason;

  /// No description provided for @biometricEnableReason.
  ///
  /// In en, this message translates to:
  /// **'Enable fingerprint sign-in'**
  String get biometricEnableReason;

  /// No description provided for @biometricSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Configure biometric access'**
  String get biometricSetupTitle;

  /// No description provided for @biometricSetupDescription.
  ///
  /// In en, this message translates to:
  /// **'Use face recognition or fingerprint to access faster and more securely.'**
  String get biometricSetupDescription;

  /// No description provided for @biometricSetupActivate.
  ///
  /// In en, this message translates to:
  /// **'Enable biometrics'**
  String get biometricSetupActivate;

  /// No description provided for @biometricSetupSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get biometricSetupSkip;

  /// No description provided for @biometricEnableDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable fingerprint sign-in?'**
  String get biometricEnableDialogTitle;

  /// No description provided for @biometricEnableDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'You will be able to access your vault with your fingerprint or Face ID without typing your email and password every time.'**
  String get biometricEnableDialogMessage;

  /// No description provided for @biometricEnableDialogNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get biometricEnableDialogNotNow;

  /// No description provided for @biometricEnableDialogActivate.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get biometricEnableDialogActivate;

  /// No description provided for @biometricEnabledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Biometric access enabled successfully.'**
  String get biometricEnabledSuccess;

  /// No description provided for @biometricAccessEnabledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Biometric access enabled successfully.'**
  String get biometricAccessEnabledSuccessfully;

  /// No description provided for @biometricDisabledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint sign-in disabled.'**
  String get biometricDisabledSuccess;

  /// No description provided for @biometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available'**
  String get biometricUnavailable;

  /// No description provided for @biometricAuthenticationNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available'**
  String get biometricAuthenticationNotAvailable;

  /// No description provided for @biometricNotEnrolled.
  ///
  /// In en, this message translates to:
  /// **'Please configure face recognition or fingerprint in Android settings'**
  String get biometricNotEnrolled;

  /// No description provided for @biometricConfigureInSettings.
  ///
  /// In en, this message translates to:
  /// **'Please configure face recognition or fingerprint in Android settings'**
  String get biometricConfigureInSettings;

  /// No description provided for @biometricEnableFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication could not be enabled.'**
  String get biometricEnableFailed;

  /// No description provided for @biometricAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication failed'**
  String get biometricAuthFailed;

  /// No description provided for @biometricUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get biometricUnlockTitle;

  /// No description provided for @biometricUnlockSubtitleAvailable.
  ///
  /// In en, this message translates to:
  /// **'Access with your fingerprint or Face ID'**
  String get biometricUnlockSubtitleAvailable;

  /// No description provided for @biometricUnlockSubtitleUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometrics are not available on this device'**
  String get biometricUnlockSubtitleUnavailable;

  /// No description provided for @faceSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Configure face recognition'**
  String get faceSetupTitle;

  /// No description provided for @faceSetupDescription.
  ///
  /// In en, this message translates to:
  /// **'Use face recognition to unlock Archivero Seguro faster.'**
  String get faceSetupDescription;

  /// No description provided for @faceSetupActivate.
  ///
  /// In en, this message translates to:
  /// **'Enable face recognition'**
  String get faceSetupActivate;

  /// No description provided for @faceSetupSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get faceSetupSkip;

  /// No description provided for @faceRecognitionNotAvailableOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Face recognition is not available on this device'**
  String get faceRecognitionNotAvailableOnDevice;

  /// No description provided for @faceRecognitionConfigureInSettings.
  ///
  /// In en, this message translates to:
  /// **'Please configure face recognition in Android settings'**
  String get faceRecognitionConfigureInSettings;

  /// No description provided for @faceRecognitionNotAvailableOrConfigured.
  ///
  /// In en, this message translates to:
  /// **'Face recognition is not available or not configured'**
  String get faceRecognitionNotAvailableOrConfigured;

  /// No description provided for @faceAuthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Face authentication failed'**
  String get faceAuthenticationFailed;

  /// No description provided for @faceAuthenticationEnabledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Face authentication enabled successfully'**
  String get faceAuthenticationEnabledSuccessfully;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Summary of your secure credentials'**
  String get dashboardSubtitle;

  /// No description provided for @dashboardRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get dashboardRefresh;

  /// No description provided for @dashboardSummaryCredentials.
  ///
  /// In en, this message translates to:
  /// **'Credentials'**
  String get dashboardSummaryCredentials;

  /// No description provided for @dashboardSummaryCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get dashboardSummaryCategories;

  /// No description provided for @dashboardSummaryFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get dashboardSummaryFavorites;

  /// No description provided for @dashboardSummaryRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get dashboardSummaryRecent;

  /// No description provided for @dashboardSecurityScore.
  ///
  /// In en, this message translates to:
  /// **'Security score'**
  String get dashboardSecurityScore;

  /// No description provided for @dashboardSecurityScoreSafe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get dashboardSecurityScoreSafe;

  /// No description provided for @dashboardSecurityScoreImproveable.
  ///
  /// In en, this message translates to:
  /// **'Improveable'**
  String get dashboardSecurityScoreImproveable;

  /// No description provided for @dashboardSecurityScoreRisk.
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get dashboardSecurityScoreRisk;

  /// No description provided for @dashboardSecurityScoreDescription.
  ///
  /// In en, this message translates to:
  /// **'Your credentials are protected with end-to-end encryption.'**
  String get dashboardSecurityScoreDescription;

  /// No description provided for @dashboardRecentCredentials.
  ///
  /// In en, this message translates to:
  /// **'Recently added'**
  String get dashboardRecentCredentials;

  /// No description provided for @dashboardNoCredentials.
  ///
  /// In en, this message translates to:
  /// **'No credentials yet'**
  String get dashboardNoCredentials;

  /// No description provided for @dashboardAddCredential.
  ///
  /// In en, this message translates to:
  /// **'Add credential'**
  String get dashboardAddCredential;

  /// No description provided for @dashboardFavoriteCredentials.
  ///
  /// In en, this message translates to:
  /// **'Favorite Credentials'**
  String get dashboardFavoriteCredentials;

  /// No description provided for @dashboardNoFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite credentials'**
  String get dashboardNoFavorites;

  /// No description provided for @dashboardNoFavoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Star a credential to see it here'**
  String get dashboardNoFavoritesHint;

  /// No description provided for @dashboardTopCategories.
  ///
  /// In en, this message translates to:
  /// **'Top Categories'**
  String get dashboardTopCategories;

  /// No description provided for @dashboardNoCategories.
  ///
  /// In en, this message translates to:
  /// **'No categories yet'**
  String get dashboardNoCategories;

  /// No description provided for @dashboardCreateCategory.
  ///
  /// In en, this message translates to:
  /// **'Create category'**
  String get dashboardCreateCategory;

  /// No description provided for @dashboardSecurityAlerts.
  ///
  /// In en, this message translates to:
  /// **'Security Alerts'**
  String get dashboardSecurityAlerts;

  /// No description provided for @dashboardNoAlerts.
  ///
  /// In en, this message translates to:
  /// **'No security alerts'**
  String get dashboardNoAlerts;

  /// No description provided for @dashboardNoAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your credentials are protected'**
  String get dashboardNoAlertsSubtitle;

  /// No description provided for @dashboardNoDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get dashboardNoDate;

  /// No description provided for @dashboardToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dashboardToday;

  /// No description provided for @dashboardYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dashboardYesterday;

  /// No description provided for @dashboardError.
  ///
  /// In en, this message translates to:
  /// **'Error loading dashboard. Please try again.'**
  String get dashboardError;

  /// No description provided for @dashboardRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get dashboardRetry;

  /// No description provided for @dashboardNoIdentifier.
  ///
  /// In en, this message translates to:
  /// **'No identifier'**
  String get dashboardNoIdentifier;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileEditName.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get profileEditName;

  /// No description provided for @profileNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileNameLabel;

  /// No description provided for @profileNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get profileNameHint;

  /// No description provided for @profileNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get profileNameRequired;

  /// No description provided for @profileNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Minimum 2 characters'**
  String get profileNameMinLength;

  /// No description provided for @profileNameMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Maximum 80 characters'**
  String get profileNameMaxLength;

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get profileSaveChanges;

  /// No description provided for @profileChangePin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get profileChangePin;

  /// No description provided for @profileCurrentPin.
  ///
  /// In en, this message translates to:
  /// **'Current PIN'**
  String get profileCurrentPin;

  /// No description provided for @profileCurrentPinRequired.
  ///
  /// In en, this message translates to:
  /// **'Current PIN is required'**
  String get profileCurrentPinRequired;

  /// No description provided for @profileNewPin.
  ///
  /// In en, this message translates to:
  /// **'New PIN (4-6 digits)'**
  String get profileNewPin;

  /// No description provided for @profileNewPinRequired.
  ///
  /// In en, this message translates to:
  /// **'New PIN is required'**
  String get profileNewPinRequired;

  /// No description provided for @profileNewPinDigits.
  ///
  /// In en, this message translates to:
  /// **'PIN must contain only digits'**
  String get profileNewPinDigits;

  /// No description provided for @profileNewPinLength.
  ///
  /// In en, this message translates to:
  /// **'PIN must be between 4 and 6 digits'**
  String get profileNewPinLength;

  /// No description provided for @profileNewPinDifferent.
  ///
  /// In en, this message translates to:
  /// **'New PIN must be different from current'**
  String get profileNewPinDifferent;

  /// No description provided for @profileChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get profileChangePassword;

  /// No description provided for @profileCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get profileCurrentPassword;

  /// No description provided for @profileCurrentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get profileCurrentPasswordRequired;

  /// No description provided for @profileNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get profileNewPassword;

  /// No description provided for @profileNewPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get profileNewPasswordRequired;

  /// No description provided for @profileNewPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get profileNewPasswordMinLength;

  /// No description provided for @profileNewPasswordDifferent.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from current'**
  String get profileNewPasswordDifferent;

  /// No description provided for @profileConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get profileConfirmPassword;

  /// No description provided for @profileConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get profileConfirmPasswordRequired;

  /// No description provided for @profilePasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get profilePasswordsDoNotMatch;

  /// No description provided for @profilePasswordChangeWarning.
  ///
  /// In en, this message translates to:
  /// **'Changing your password will close all active sessions.'**
  String get profilePasswordChangeWarning;

  /// No description provided for @profileSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please sign in again.'**
  String get profileSessionExpired;

  /// No description provided for @profilePinUpdated.
  ///
  /// In en, this message translates to:
  /// **'PIN updated successfully'**
  String get profilePinUpdated;

  /// No description provided for @profilePasswordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully. You will be redirected to sign in.'**
  String get profilePasswordUpdated;

  /// No description provided for @profileNameUpdated.
  ///
  /// In en, this message translates to:
  /// **'Name updated successfully'**
  String get profileNameUpdated;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileLogout;

  /// No description provided for @profileErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile'**
  String get profileErrorLoad;

  /// No description provided for @profileErrorUpdate.
  ///
  /// In en, this message translates to:
  /// **'Error updating profile'**
  String get profileErrorUpdate;

  /// No description provided for @profileErrorPin.
  ///
  /// In en, this message translates to:
  /// **'Error changing PIN'**
  String get profileErrorPin;

  /// No description provided for @profileErrorPassword.
  ///
  /// In en, this message translates to:
  /// **'Error changing password'**
  String get profileErrorPassword;

  /// No description provided for @profileSecuritySettings.
  ///
  /// In en, this message translates to:
  /// **'Security settings'**
  String get profileSecuritySettings;

  /// No description provided for @profileSecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Biometrics, PIN and more'**
  String get profileSecuritySubtitle;

  /// No description provided for @profileStatsCredentials.
  ///
  /// In en, this message translates to:
  /// **'Credentials'**
  String get profileStatsCredentials;

  /// No description provided for @profileStatsCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get profileStatsCategories;

  /// No description provided for @profileStatsFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get profileStatsFavorites;

  /// No description provided for @profileRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get profileRole;

  /// No description provided for @profileActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileActive;

  /// No description provided for @profileInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get profileInactive;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your most important credentials'**
  String get favoritesSubtitle;

  /// No description provided for @favoritesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by service, email or username'**
  String get favoritesSearchHint;

  /// No description provided for @favoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get favoritesEmpty;

  /// No description provided for @favoritesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Star a credential to see it here'**
  String get favoritesEmptyHint;

  /// No description provided for @favoritesNoResults.
  ///
  /// In en, this message translates to:
  /// **'No favorites found'**
  String get favoritesNoResults;

  /// No description provided for @favoritesNoResultsHint.
  ///
  /// In en, this message translates to:
  /// **'Try searching with a different service, email or username.'**
  String get favoritesNoResultsHint;

  /// No description provided for @favoritesRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get favoritesRemove;

  /// No description provided for @favoritesErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Error loading favorites'**
  String get favoritesErrorLoad;

  /// No description provided for @favoritesErrorAction.
  ///
  /// In en, this message translates to:
  /// **'Error updating favorite'**
  String get favoritesErrorAction;

  /// No description provided for @favoritesRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get favoritesRetry;

  /// No description provided for @favoritesNoDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get favoritesNoDate;

  /// No description provided for @favoritesToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get favoritesToday;

  /// No description provided for @favoritesYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get favoritesYesterday;

  /// No description provided for @favoritesStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get favoritesStrength;

  /// No description provided for @favoritesNoIdentifier.
  ///
  /// In en, this message translates to:
  /// **'No identifier'**
  String get favoritesNoIdentifier;

  /// No description provided for @profileImageNoPhoto.
  ///
  /// In en, this message translates to:
  /// **'No profile picture yet.'**
  String get profileImageNoPhoto;

  /// No description provided for @profileImageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile picture updated successfully.'**
  String get profileImageUpdated;

  /// No description provided for @profileImageDeleted.
  ///
  /// In en, this message translates to:
  /// **'Profile picture deleted successfully.'**
  String get profileImageDeleted;

  /// No description provided for @profileImageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File exceeds maximum size of 5 MB.'**
  String get profileImageTooLarge;

  /// No description provided for @profileImageInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid format. Use JPG, PNG or WEBP.'**
  String get profileImageInvalidFormat;

  /// No description provided for @profileImageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile picture.'**
  String get profileImageLoadError;

  /// No description provided for @profileImageUploadError.
  ///
  /// In en, this message translates to:
  /// **'Error uploading profile picture.'**
  String get profileImageUploadError;

  /// No description provided for @profileImageDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting profile picture.'**
  String get profileImageDeleteError;

  /// No description provided for @profileImagePickGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get profileImagePickGallery;

  /// No description provided for @profileImagePickCamera.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get profileImagePickCamera;

  /// No description provided for @profileImageDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete photo'**
  String get profileImageDelete;

  /// No description provided for @profileImageChange.
  ///
  /// In en, this message translates to:
  /// **'Change profile picture'**
  String get profileImageChange;

  /// No description provided for @profileImageUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading photo...'**
  String get profileImageUploading;

  /// No description provided for @profileImageDeleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting photo...'**
  String get profileImageDeleting;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Use System Theme'**
  String get themeSystem;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSection;

  /// No description provided for @passwordGeneratorTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Generator'**
  String get passwordGeneratorTitle;

  /// No description provided for @passwordGeneratorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create strong, unique passwords.'**
  String get passwordGeneratorSubtitle;

  /// No description provided for @passwordGeneratorGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get passwordGeneratorGenerating;

  /// No description provided for @passwordGeneratorVeryStrong.
  ///
  /// In en, this message translates to:
  /// **'Very Strong'**
  String get passwordGeneratorVeryStrong;

  /// No description provided for @passwordGeneratorStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordGeneratorStrong;

  /// No description provided for @passwordGeneratorMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get passwordGeneratorMedium;

  /// No description provided for @passwordGeneratorLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get passwordGeneratorLength;

  /// No description provided for @passwordGeneratorUppercase.
  ///
  /// In en, this message translates to:
  /// **'Uppercase (A-Z)'**
  String get passwordGeneratorUppercase;

  /// No description provided for @passwordGeneratorLowercase.
  ///
  /// In en, this message translates to:
  /// **'Lowercase (a-z)'**
  String get passwordGeneratorLowercase;

  /// No description provided for @passwordGeneratorNumbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers (0-9)'**
  String get passwordGeneratorNumbers;

  /// No description provided for @passwordGeneratorSymbols.
  ///
  /// In en, this message translates to:
  /// **'Symbols (!@#\$%)'**
  String get passwordGeneratorSymbols;

  /// No description provided for @passwordGeneratorAvoidSimilar.
  ///
  /// In en, this message translates to:
  /// **'Avoid similar characters'**
  String get passwordGeneratorAvoidSimilar;

  /// No description provided for @passwordGeneratorGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate new password'**
  String get passwordGeneratorGenerate;

  /// No description provided for @passwordGeneratorCopied.
  ///
  /// In en, this message translates to:
  /// **'Password copied to clipboard'**
  String get passwordGeneratorCopied;

  /// No description provided for @passwordGeneratorCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy password'**
  String get passwordGeneratorCopy;

  /// No description provided for @passwordGeneratorScoreOutOf.
  ///
  /// In en, this message translates to:
  /// **'/100'**
  String get passwordGeneratorScoreOutOf;

  /// No description provided for @dashboardGeneratePassword.
  ///
  /// In en, this message translates to:
  /// **'Generate password'**
  String get dashboardGeneratePassword;

  /// No description provided for @dashboardMyProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get dashboardMyProfile;

  /// No description provided for @dashboardSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get dashboardSecurity;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome,'**
  String get dashboardWelcome;

  /// No description provided for @dashboardHelloUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, User'**
  String get dashboardHelloUser;

  /// No description provided for @dashboardViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get dashboardViewAll;

  /// No description provided for @dashboardRecentAdded.
  ///
  /// In en, this message translates to:
  /// **'Recently Added'**
  String get dashboardRecentAdded;

  /// No description provided for @dashboardNoCredentialsMessage.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any credentials yet. Create your first secure credential.'**
  String get dashboardNoCredentialsMessage;

  /// No description provided for @homeWebs.
  ///
  /// In en, this message translates to:
  /// **'Webs'**
  String get homeWebs;

  /// No description provided for @homeBanks.
  ///
  /// In en, this message translates to:
  /// **'Banks'**
  String get homeBanks;

  /// No description provided for @homeWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get homeWork;

  /// No description provided for @homeCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get homeCategories;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'Archivero\nSeguro'**
  String get splashTitle;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your credentials protected'**
  String get splashSubtitle;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'STARTING'**
  String get splashLoading;

  /// No description provided for @biometricAuthFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication could not be completed.'**
  String get biometricAuthFailedMessage;

  /// No description provided for @biometricDeviceNotSupported.
  ///
  /// In en, this message translates to:
  /// **'This device does not support biometric authentication.'**
  String get biometricDeviceNotSupported;

  /// No description provided for @biometricNotEnrolledMessage.
  ///
  /// In en, this message translates to:
  /// **'You have no fingerprints or Face ID configured on this device.'**
  String get biometricNotEnrolledMessage;

  /// No description provided for @biometricTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts. Try again later.'**
  String get biometricTooManyAttempts;

  /// No description provided for @biometricBlocked.
  ///
  /// In en, this message translates to:
  /// **'Biometrics is blocked. Unlock it from device settings.'**
  String get biometricBlocked;

  /// No description provided for @biometricCancelled.
  ///
  /// In en, this message translates to:
  /// **'Authentication cancelled.'**
  String get biometricCancelled;

  /// No description provided for @biometricOperationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation could not be completed.'**
  String get biometricOperationFailed;

  /// No description provided for @formCategoryColorBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get formCategoryColorBlue;

  /// No description provided for @formCategoryColorRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get formCategoryColorRed;

  /// No description provided for @formCategoryColorGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get formCategoryColorGreen;

  /// No description provided for @formCategoryColorYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get formCategoryColorYellow;

  /// No description provided for @formCategoryColorPurple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get formCategoryColorPurple;

  /// No description provided for @formCategoryColorPink.
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get formCategoryColorPink;

  /// No description provided for @formCategoryColorOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get formCategoryColorOrange;

  /// No description provided for @formCategoryColorGray.
  ///
  /// In en, this message translates to:
  /// **'Gray'**
  String get formCategoryColorGray;

  /// No description provided for @formCategoryIconGlobe.
  ///
  /// In en, this message translates to:
  /// **'Globe'**
  String get formCategoryIconGlobe;

  /// No description provided for @formCategoryIconPerson.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get formCategoryIconPerson;

  /// No description provided for @formCategoryIconWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get formCategoryIconWork;

  /// No description provided for @formCategoryIconBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get formCategoryIconBank;

  /// No description provided for @formCategoryIconEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get formCategoryIconEmail;

  /// No description provided for @formCategoryIconPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get formCategoryIconPhone;

  /// No description provided for @formCategoryIconWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get formCategoryIconWifi;

  /// No description provided for @formCategoryIconStudy.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get formCategoryIconStudy;

  /// No description provided for @formCategoryIconShield.
  ///
  /// In en, this message translates to:
  /// **'Shield'**
  String get formCategoryIconShield;

  /// No description provided for @formCategoryIconCloud.
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get formCategoryIconCloud;

  /// No description provided for @formCategoryIconStar.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get formCategoryIconStar;

  /// No description provided for @formCategoryIconHeart.
  ///
  /// In en, this message translates to:
  /// **'Heart'**
  String get formCategoryIconHeart;

  /// No description provided for @credentialsFilterCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get credentialsFilterCategories;

  /// No description provided for @credentialsFilterFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get credentialsFilterFavorites;

  /// No description provided for @passwordStrengthVeryStrong.
  ///
  /// In en, this message translates to:
  /// **'VERY STRONG'**
  String get passwordStrengthVeryStrong;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
