import 'package:web/web.dart' as web;

String? getGoogleClientId() {
  final meta = web.document.querySelector('meta[name="google-signin-client_id"]');
  return meta?.getAttribute('content');
}
