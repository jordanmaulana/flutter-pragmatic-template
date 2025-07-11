import 'package:url_launcher/url_launcher.dart';

import '../ui/components/popup.dart';

class UrlUtility {
  static String? getYoutubeThumbnail(String videoUrl) {
    // Pattern covering both regular and embed YouTube URLs
    RegExp pattern = RegExp(
        r'(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

    // Match the pattern against the URL
    Match? match = pattern.firstMatch(videoUrl);

    // Return the captured group which is the YouTube ID, or an empty string if no match is found
    if (match != null && match.groupCount >= 1) {
      String? thumbnail = match.group(1);
      if (thumbnail != null) {
        return 'https://img.youtube.com/vi/$thumbnail/0.jpg';
      }
      return null;
    }
    return null;
  }

  static Future<void> openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      VPopup.error("Can't open the URL");
    }
  }
}
