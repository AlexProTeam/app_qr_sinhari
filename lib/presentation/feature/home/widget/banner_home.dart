import 'package:flutter/material.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../../../common/model/banner_model.dart';
import '../../../../app/di/injection.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/login/usecases/app_usecase.dart';
import '../../../widgets/banner_slide_image.dart';

class BannerHomeWidget extends StatefulWidget {
  const BannerHomeWidget({Key? key}) : super(key: key);

  @override
  State<BannerHomeWidget> createState() => _BannerHomeWidgetState();
}

class _BannerHomeWidgetState extends State<BannerHomeWidget> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();
  final List<BannerResponse> _bannerModel = [];
  bool _isBannerLoading = false;

  @override
  void initState() {
    _initBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isBannerLoading) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 22, top: 10),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_bannerModel.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 22, top: 10),
      child: BannerSlideImage(
        height: (MediaQuery.of(context).size.width - 32) * 4 / 9,
        banners: _bannerModel.map((e) => e).toList(),
        images: _bannerModel.map((e) => e.url ?? '').toList(),
      ),
    );
  }

  Future<void> _initBanner() async {
    try {
      setState(() {
        _isBannerLoading = true;
      });

      final result = await _appUseCase.getBannerHome();

      _bannerModel.addAll(result);
    } on ApiException catch (e) {
      ToastManager.showToast(context, text: e.message);
    }

    setState(() {
      _isBannerLoading = false;
    });
  }
}
