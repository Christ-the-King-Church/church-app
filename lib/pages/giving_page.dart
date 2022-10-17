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
  late StreamSubscription _onDestroy;

  // On urlChanged stream
  late StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  late StreamSubscription<WebViewStateChanged> _onStateChanged;

  late StreamSubscription<WebViewHttpError> _onHttpError;

  late StreamSubscription<double> _onProgressChanged;

  late StreamSubscription<double> _onScrollYChanged;

  late StreamSubscription<double> _onScrollXChanged;

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
