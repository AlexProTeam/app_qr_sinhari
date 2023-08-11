import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

import '../../../common/const/icon_constant.dart';
import '../../../common/utils/date_utils.dart';

class ArgumentDetailNewScreen {
  final int? newsDetail;
  final String? url;

  ArgumentDetailNewScreen({this.newsDetail, this.url});
}

class DetailNewScreen extends StatefulWidget {
  final ArgumentDetailNewScreen? argument;

  const DetailNewScreen({Key? key, this.argument}) : super(key: key);

  @override
  DetailNewScreenState createState() => DetailNewScreenState();
}

class DetailNewScreenState extends State<DetailNewScreen> {
  bool isLoadding = false;

  Map _data = {};

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      isLoadding = true;

      ///todo: change to base later

      var request = http.MultipartRequest(
          'POST', Uri.parse('https://beta.sinhairvietnam.vn/api/news_detail'));
      request.fields.addAll({'news_id': '${widget.argument?.newsDetail}'});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final test = await response.stream.bytesToString();
        _data = json.decode(test)['data'];
      }
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {
      isLoadding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.white,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(33),
                    child: Container(
                      height: 33,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(33),
                          topRight: Radius.circular(33),
                        ),
                      ),
                    ),
                  ),
                  stretch: true,
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.06),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  expandedHeight: MediaQuery.of(context).size.height / 4,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CustomImageNetwork(
                      url: '${widget.argument?.url}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          _data['title'] ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Image.asset(
                              IconConst.miniClock,
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              DateUtilsApp.formatterDetail(
                                  DateTime.parse(_data['created_at'] ?? '')),
                              style: const TextStyle(
                                color: AppColors.colorACACAC,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (_data['content'] != null)
                        Html(
                          data: _data['content'],
                          style: {
                            "html": Style(
                              backgroundColor: Colors.white,
                              color: AppColors.grey9,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize(14),
                              fontStyle: FontStyle.normal,
                              wordSpacing: 1.5,
                              alignment: Alignment.center,
                              padding: HtmlPaddings.symmetric(horizontal: 9)
                                  .copyWith(bottom: HtmlPadding(100)),
                            ),
                            'img': Style(
                              width: Width(
                                  MediaQuery.of(context).size.width * 0.9),
                            )
                          },
                        )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
