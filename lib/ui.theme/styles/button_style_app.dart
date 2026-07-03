import 'package:archive_secure/ui.theme/size_app.dart';
import 'package:archive_secure/ui.theme/styles/color_scheme_app.dart';
import 'package:archive_secure/ui.theme/styles/text_style_app.dart';

import 'package:flutter/material.dart';

final theme = AppColorScheme.light;


ButtonStyle get blueButtonStyle => ElevatedButton.styleFrom(
  backgroundColor: theme.secondary,
  foregroundColor: theme.onPrimary,
  textStyle: textStyleSecondary.bodyMedium,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(sizeRadiusButton),
  ),
);



ButtonStyle get whiteButtonStyle => ElevatedButton.styleFrom(
  backgroundColor: theme.onPrimary,
  foregroundColor: theme.primary,
  textStyle:  textStyleSecondary.displayMedium,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(sizeRadiusButton),
  ),
);