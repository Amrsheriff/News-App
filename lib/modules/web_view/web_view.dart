
import 'package:flutter/material.dart';
import 'package:untitled/modules/web_view/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewScreen extends StatelessWidget {

  final String url;
  webViewScreen(this.url);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
      //WebViewWidget(controller: controller,),
    );
  }
}
