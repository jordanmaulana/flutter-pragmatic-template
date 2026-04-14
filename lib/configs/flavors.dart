// ignore_for_file: unintended_html_in_doc_comment

import 'constants.dart';

/// Defines every variables that change between testing build and production build.
///
/// e.g.: Api URL, Sentry DSN, In App Purchase ids, etc.
/// How to initiate:
/// Add Get.put(BuildFlavor.initiate(buildFlavorType: BuildFlavorType.production)); before runApp in every file entry [main.dart, main_staging.dart, etc]
/// How to use values:
/// String apiUrl = (Get.find<BuildFlavor>()).apiUrl;
///
class BuildFlavor {
  late String apiUrl;

  BuildFlavor({required this.apiUrl});

  factory BuildFlavor.initiate({required BuildFlavorType buildFlavorType}) {
    switch (buildFlavorType) {
      case BuildFlavorType.production:
        return BuildFlavor(apiUrl: Constants.productionUrl);
      case BuildFlavorType.staging:
        return BuildFlavor(apiUrl: Constants.stagingUrl);
    }
  }
}

enum BuildFlavorType { staging, production }
