import 'package:flutter/material.dart';

import '../../../../common/network/client.dart';
import '../../../../common/utils/common_util.dart';
import '../../../../re_base/app/di/injection.dart';
import '../../../themes/theme_color.dart';
import '../../news/history_model.dart';
import 'item_news.dart';

class NewsHomeWidget extends StatefulWidget {
  const NewsHomeWidget({Key? key}) : super(key: key);

  @override
  State<NewsHomeWidget> createState() => _NewsHomeWidgetState();
}

class _NewsHomeWidgetState extends State<NewsHomeWidget> {
  bool _isLoading = false;
  final List<NewsModel> _newsModel = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 22, top: 10, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Tin tức mới nhất',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.colorEF4948),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    if (_newsModel.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 22, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12),
            child: const Text('Tin tức mới nhất',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.colorEF4948,
                )),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              itemBuilder: (_, index) => ItemNews(
                model: _newsModel[index],
              ),
              itemCount: _newsModel.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final dataNew =
          await getIt<AppClient>().post('list_news', handleResponse: false);
      dataNew['data'].forEach((e) {
        _newsModel.add(NewsModel.fromJson(e));
      });
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {
      _isLoading = false;
    });
  }
}
