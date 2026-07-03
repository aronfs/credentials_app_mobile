import 'package:archive_secure/ui.theme/custom_text_style.dart';
import 'package:archive_secure/ui.theme/styles/color_scheme_app.dart';
import 'package:flutter/material.dart';


final ColorScheme theme = AppColorScheme.light;

TextTheme get textStyleBase =>
    AppTextStyle.textTheme(theme.onSurface);

TextTheme get textStylePrimary =>
    AppTextStyle.textTheme(theme.primary);

TextTheme get textStyleSecondary =>
    AppTextStyle.textTheme(theme.secondary);

TextTheme get textStyleWhite =>
    AppTextStyle.textTheme(Colors.white);