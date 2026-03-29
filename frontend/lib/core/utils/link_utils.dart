import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalLink(String value) async {
  if (value.isEmpty || value.startsWith('TODO_')) {
    return;
  }

  final uri = Uri.parse(value);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
