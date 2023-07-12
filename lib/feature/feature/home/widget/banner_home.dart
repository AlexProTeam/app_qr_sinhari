import 'package:flutter/material.dart';

import '../../../../common/model/banner_model.dart';
import '../../../../common/network/client.dart';
import '../../../../common/utils/common_util.dart';
import '../../../injector_container.dart';
import '../../../widgets/banner_slide_image.dart';

class BannerHomeWidget extends StatefulWidget {
  const BannerHomeWidget({Key? key}) : super(key: key);

  @override
  State<BannerHomeWidget> createState() => _BannerHomeWidgetState();
}

class _BannerHomeWidgetState extends State<BannerHomeWidget> {
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
        height: MediaQuery.of(context).size.height * 0.2,
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

      final data = await injector<AppClient>().get('banners');

      data['data'].forEach((e) {
        _bannerModel.add(BannerResponse.fromJson(e));
      });
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {
      _isBannerLoading = false;
    });
  }
}
