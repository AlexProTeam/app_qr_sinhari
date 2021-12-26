import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import '../../injector_container.dart';
import 'package:qrcode/feature/feature/news/new_deyail_model.dart';
import 'package:http/http.dart' as http;

class ArgumentDetailNewScreen {
  final int? news_detail;
  final String? url;

  ArgumentDetailNewScreen({this.news_detail, this.url});
}

class DetailNewScreen extends StatefulWidget {
  final ArgumentDetailNewScreen? argument;

  const DetailNewScreen({Key? key, this.argument}) : super(key: key);

  @override
  _DetailNewScreenState createState() => _DetailNewScreenState();
}

class _DetailNewScreenState extends State<DetailNewScreen> {
  NewsDetailModel? _newDetailModel;
  TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Map _data = {};

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://admin.sinhairvietnam.vn/api/news_detail'));
      request.fields.addAll({'news_id': '${widget.argument?.news_detail}'});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final test = await response.stream.bytesToString();
        _data = json.decode(test)['data'];
      }
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        customAppBar: CustomAppBar(
          title: 'Chi tiết tin tức',
          iconLeftTap: () {
            Routes.instance.pop();
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomImageNetwork(
                url: '${widget.argument?.url}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                border: 12,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _data['title'] ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _data['created_at'] ?? '',
                      style: TextStyle(color: Colors.amber, fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _data['content'] != null
                        ? Html(
                            data: _data['content'],
                            style: {
                              "html": Style(
                                backgroundColor: Colors.white,
                                color: AppColors.grey9,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize(14),
                                padding: EdgeInsets.all(0),
                                fontStyle: FontStyle.normal,
                                wordSpacing: 1.5,
                              ),
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
