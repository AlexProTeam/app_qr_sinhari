import 'package:flutter/material.dart';
import 'package:qrcode/common/local/local_app.dart';

import '../../app/di/injection.dart';
import '../../app/managers/const/key_save_data_local.dart';
import '../../app/managers/const/string_const.dart';
import '../../app/managers/style_manager.dart';
import '../../app/route/common_util.dart';

class BottomSheetSelectImage extends StatefulWidget {
  final Function? onPhotoTap;
  final Function? onCameraTap;

  const BottomSheetSelectImage({Key? key, this.onPhotoTap, this.onCameraTap})
      : super(key: key);

  @override
  BottomSheetSelectImageState createState() => BottomSheetSelectImageState();
}

class BottomSheetSelectImageState extends State<BottomSheetSelectImage> {
  void _requestPermission(context, bool camera) async {
    bool? checkPermissionCamera = getIt<LocalApp>()
            .getBool(KeySaveDataLocal.havedAcceptPermissionCamera) ??
        false;
    bool? checkPermissionPhoto = getIt<LocalApp>()
            .getBool(KeySaveDataLocal.havedAcceptPermissionPhoto) ??
        false;
    if (camera && checkPermissionCamera) {
      Navigator.pop(context);
      widget.onCameraTap!();
      return;
    }
    if (!camera && checkPermissionPhoto) {
      widget.onPhotoTap!();
      Navigator.pop(context);
      return;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    CommonUtil.showAlertDialog(
      context,
      showCancel: true,
      title: camera ? 'Camera' : 'Bộ sưu tập',
      message: StringConst.contentCamera,
      textOk: StringConst.allow,
      textCancel: StringConst.notAllow,
      onOk: () {
        if (camera) {
          widget.onCameraTap!();
        } else {
          widget.onPhotoTap!();
        }
        Navigator.pop(context);
      },
      onCancel: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.5),
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: <Widget>[
                _itemButton(() {
                  _requestPermission(context, false);
                }, 'Thư viện'),
                const Divider(height: 0.1, color: Colors.grey),
                _itemButton(() {
                  _requestPermission(context, true);
                }, 'Camera'),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  'Hủy',
                  style: TextStyleManager.normalBlue.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemButton(Function onTap, String text) => InkWell(
        onTap: () async {
          onTap();
        },
        child: SizedBox(
          height: 48,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyleManager.normalBlack.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
}