/*
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ThreeDBackground extends StatelessWidget {
  final Widget child;

  const ThreeDBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse('https://mohnasr137.github.io/tube3D/'),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                supportZoom: false,
                useOnLoadResource: true,
              ),
              onLoadStart: (controller, url) {
                print("Page started loading: $url");
              },
              onLoadStop: (controller, url) {
                print("Page finished loading: $url");
              },
              onLoadError: (controller, url, code, message) {
                print("Error loading page: $message");
              },
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Container(
                colors: Colors.black.withOpacity(0.2),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
