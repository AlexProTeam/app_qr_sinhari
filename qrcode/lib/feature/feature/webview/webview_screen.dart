import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Liên hệ',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl: '${widget.url}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                  // injector<LoadingBloc>().add(FinishLoading());
                },
                onProgress: (int progress) {
                  // injector<LoadingBloc>().add(StartLoading());
                },
                javascriptChannels: <JavascriptChannel>{

                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onWebResourceError: (WebResourceError error){
                  // injector<LoadingBloc>().add(FinishLoading());
                },

                onPageStarted: (String url) {
                  // injector<LoadingBloc>().add(FinishLoading());
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  // injector<LoadingBloc>().add(FinishLoading());
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              );
            }),
          ),
        ],
      ),
    );
  }
}
