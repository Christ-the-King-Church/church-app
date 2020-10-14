import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class GivingPageWidget extends StatefulWidget {
  @override
  _GivingPageWidgetState createState() => _GivingPageWidgetState();
}

class _GivingPageWidgetState extends State {
  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onProgressChanged;

  StreamSubscription<double> _onScrollYChanged;

  StreamSubscription<double> _onScrollXChanged;

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    return const WebviewScaffold(
        url: 'https://www.basswoodchurch.net/give',
        withZoom: true,
        hidden: true);
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    flutterWebViewPlugin.dispose();

    super.dispose();
  }
}
