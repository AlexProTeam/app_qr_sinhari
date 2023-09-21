import 'package:flutter/material.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/all_app_doumain/usecases/app_usecase.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../widgets/toast_manager.dart';
import '../../news/history_model.dart';
import 'item_news.dart';

class NewsHomeWidget extends StatefulWidget {
  const NewsHomeWidget({Key? key}) : super(key: key);

  @override
  State<NewsHomeWidget> createState() => _NewsHomeWidgetState();
}

class _NewsHomeWidgetState extends State<NewsHomeWidget> {
  bool _isLoading = false;
  final List<NewsModelResponse> _newsModel = [];
  final AppUseCase _appUseCase = getIt<AppUseCase>();

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

      final result = await _appUseCase.getListNews();

      _newsModel.addAll(result);
    } on ApiException catch (e) {
      ToastManager.showToast(context, text: e.message);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
