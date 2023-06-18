import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_android/webview_flutter_android.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../themes/theme_text.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  WebviewScreenState createState() => WebviewScreenState();
}

class WebviewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
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
    // #enddocregion platform_features

    return CustomScaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          // Expanded(
          //   child: Builder(builder: (BuildContext context) {
          //     return WebViewWidget(
          //       controller: controller,
          //     );
          //   }),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: Color(0xFFACACAC),
                  )),
              const Text(
                'Liên hệ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(width: 35),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  IconConst.logoLogin,
                  width: 140,
                  height: 140,
                ),
                const SizedBox(height: 10),
                Container(
                    width: 343,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(
                        8,
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconConst.location,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 15),
                              RichText(
                                  text: const TextSpan(
                                      children: [
                                    TextSpan(
                                        text:
                                            ' 192 Mai Anh Tuấn, Quận\n Ba Đình, Hà Nội',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ))
                                  ],
                                      text: 'Trụ sở:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const SizedBox(width: 39),
                              RichText(
                                  text: const TextSpan(
                                      text: 'Văn phòng HCM:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      children: [
                                    TextSpan(
                                        text:
                                            ' Số nhà 76 Lê\n Lai, Quận 1, Tp Hồ Chí Minh',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.black))
                                  ])),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    )),
                const SizedBox(height: 12),
                Container(
                    width: 343,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(
                        8,
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconConst.hotline,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 15),
                              RichText(
                                  text: const TextSpan(
                                      children: [
                                    TextSpan(
                                        text: '19008787',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ))
                                  ],
                                      text: 'Hotline: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: const [
                              SizedBox(width: 39),
                              Text(
                                'VP HCM: 0987 655 755',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    )),
                const SizedBox(height: 12),
                Container(
                    width: 343,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(
                        8,
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconConst.mail,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 15),
                              RichText(
                                  text: const TextSpan(
                                text: 'Email:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: ' sunhair.cskh@gmail.com',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ))
                                ],
                              ))
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    )),
                const SizedBox(height: 12),
                Container(
                    width: 343,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(
                        8,
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            'Kết nối với Sinhair:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          _icon(() => {}, 'Gmail', IconConst.gmail),
                          _icon(() => {}, 'Facebook', IconConst.facebook),
                          _icon(() => {}, 'Zalo', IconConst.zalo),
                          const SizedBox(height: 17),
                        ],
                      ),
                    )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

Widget _icon(Function() onTap, String text, String iconData) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Center(
            child: Image.asset(
              iconData,
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppTextTheme.normalBlack.copyWith(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
  );
}
