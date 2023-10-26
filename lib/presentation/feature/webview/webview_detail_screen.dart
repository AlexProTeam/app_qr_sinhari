import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_android/webview_flutter_android.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../app/managers/color_manager.dart';
import '../../../app/utils/common_util.dart';
import '../../widgets/custom_scaffold.dart';

class WebViewDetailScreen extends StatefulWidget {
  final String url;

  const WebViewDetailScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  WebViewDetailScreenState createState() => WebViewDetailScreenState();
}

class WebViewDetailScreenState extends State<WebViewDetailScreen> {
  bool get _isUrl =>
      widget.url.startsWith('http') || widget.url.startsWith('https');

  @override
  Widget build(BuildContext context) {
    if (!_isUrl) {
      return SafeArea(
        child: CustomScaffold(
          customAppBar: CustomAppBar(
            title: 'Chi tiết thông báo',
            iconLeftTap: () => Navigator.pop(context),
          ),
          body: Builder(builder: (BuildContext context) {
            return Html(
              data: widget.url,
              shrinkWrap: true,
              onLinkTap: (url, attributes, element) =>
                  CommonUtil.runUrl(url ?? ''),
              style: {
                "html": Style(
                  backgroundColor: Colors.transparent,
                  color: AppColors.grey9,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize(14.sp),
                  padding: HtmlPaddings.symmetric(horizontal: 16.w),
                  fontStyle: FontStyle.normal,
                  wordSpacing: 1.5,
                ),
                'img': Style(
                  width: Width(MediaQuery.of(context).size.width),
                  height: Height(
                    MediaQuery.of(context).size.width * 1.5,
                  ),
                ),
              },
            );
          }),
        ),
      );
    }

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Chi tiết sản phẩm',
        iconLeftTap: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: Builder(builder: (BuildContext context) {
              return _isUrl
                  ? WebViewWidget(
                      controller: controller,
                    )
                  : Html(
                      data: widget.url,
                      style: {
                        "html": Style(
                          backgroundColor: Colors.transparent,
                          color: AppColors.grey9,
                          fontWeight: FontWeight.w500,
                          fontSize: FontSize(14),
                          padding: HtmlPaddings.zero,
                          fontStyle: FontStyle.normal,
                          wordSpacing: 1.5,
                        ),
                        'img': Style(
                          width: Width(MediaQuery.of(context).size.width),
                          height: Height(
                            MediaQuery.of(context).size.width * 1.5,
                          ),
                        ),
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }
}
