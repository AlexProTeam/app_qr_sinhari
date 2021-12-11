import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:device_info/device_info.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:qrcode/common/exceptions/app_exception.dart';
import 'package:qrcode/common/exceptions/connect_exception.dart';
import 'package:qrcode/common/exceptions/timeout_exception.dart';
import 'dart:ui' as ui;

import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/alert_dialog_container.dart';

class CommonUtil {
  static Future<String> getDeviceId()async{
    final DeviceInfoPlugin deviceInfoPlugin =   DeviceInfoPlugin();
    String identifier = '';
    // try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    // } catch(e) {
    //   return '';
    // }
    return identifier;
  }
  static int countNumberRowOfGridview(List? data) {
    if (data?.isEmpty ?? true) {
      return 1;
    }
    if (data!.length % 2 == 0) {
      return data.length ~/ 2;
    }
    return (data.length + 1) ~/ 2;
  }

  static void showCustomBottomSheet({
    required BuildContext context,
    required Widget child,
    double? height,
    Function? onClosed,
    EdgeInsets? margin,
    Color? backgroundColor,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        double _maxHeight =
            GScreenUtil.screenHeightDp - 100 - GScreenUtil.statusBarHeight;
        return Container(
          height: height != null ? min(height, _maxHeight) : _maxHeight,
          margin: margin ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: child,
        );
      },
    ).whenComplete(() {
      if (onClosed != null) {
        onClosed();
      }
    });
  }

  static void mapListenerSnackBarState(
      BuildContext context, SnackBarState state) {
    if (state is ShowSnackBarState) {
      var icon;
      var color;
      var title;
      switch (state.type) {
        case SnackBarType.success:
          icon = Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          );
          color = Color(0xff33B44A);
          title = "Thành công";
          break;
        case SnackBarType.warning:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Colors.orange;
          title = "Cảnh báo";
          break;
        case SnackBarType.error:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Color(0xffF63E43);
          title = "Thất bại";
          break;
        default:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Colors.grey;
          title = "Thông báo";
          break;
      }

      showFlash(
        context: Routes.instance.navigatorKey.currentContext!,
        duration: state.duration ?? Duration(milliseconds: 3000),
        builder: (context, controller) {
          return Flash.bar(
            controller: controller,
            backgroundColor: color,
            position: FlashPosition.top,
            horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
            margin: const EdgeInsets.all(8),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            forwardAnimationCurve: Curves.easeOutBack,
            reverseAnimationCurve: Curves.easeInCubic,
            child: FlashBar(
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              ),
              content: Text(
                state.mess ?? '',
                style: TextStyle(color: Colors.white),
              ),
              icon: icon,
              shouldIconPulse: true,
              showProgressIndicator: false,
            ),
          );
        },
      );
    }
  }

  static dynamic getObjectInList(List<dynamic>? list, int index) {
    if ((list?.isNotEmpty ?? false) && index < (list?.length ?? 0)) {
      return list?[index];
    }
    return null;
  }

  static bool isNull(dynamic input) {
    return ["", null, false, 0].contains(input);
  }

  static bool validateAndSave(GlobalKey<FormState> key) {
    FormState? form = key.currentState;
    if (form?.validate() ?? false) {
      form?.save();
      return true;
    }
    return false;
  }

  static bool isPhone() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 600;
  }

  static String hidePhoneNumber(String phone) {
    if (CommonUtil.isNull(phone) && phone.length > 3) {
      String endPhone = phone.substring(phone.length - 3, phone.length);
      String star = '';
      for (var i = 0; i < phone.length - 3; i++) {
        star = '*$star';
      }
      return '$star$endPhone';
    }
    return '';
  }

  static void showAlertDialog(
    BuildContext context, {
    String? message,
    String? title,
    Function? onCancel,
    Function? onOk,
    Function? onContentTap,
    bool showCancel = false,
    String? textCancel,
    String? textOk,
    Widget? child,
    bool? barrierDismissible,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: child ??
                AlertDialogContainer(
                  message: message ?? '',
                  label: title,
                  textCancel: 'Hủy',
                  textOk: 'OK',
                  cancel: () {
                    Navigator.pop(context);
                    if (onCancel != null) {
                      onCancel();
                    }
                  },
                  confirm: () {
                    Navigator.pop(context);
                    if (onOk != null) {
                      onOk();
                    }
                  },
                  showCancel: showCancel,
                ),
          );
        });
  }

  static bool isAndroidOS() {
    if (Platform.isAndroid) {
      return true;
    }
    return false;
  }

  static void dismissKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static double getBounceDegreesByKey(GlobalKey? key) {
    final RenderBox? box =
        key?.currentContext?.findRenderObject() as RenderBox?;
    final Offset? position = box?.localToGlobal(Offset.zero);
    return position?.dy ?? 0;
  }

  static Future<Uint8List?> getBytesFromAsset(String path, int size) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: size - 20, targetHeight: size);
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? result =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return result?.buffer.asUint8List();
  }

  static bool isEmptyOrNull(dynamic obj) {
    try {
      return (obj == null || obj.isEmpty);
    } catch (e) {
      return true;
    }
  }

  static bool isNotEmptyAndNull(dynamic obj) {
    try {
      return (obj != null && obj.isNotEmpty);
    } catch (e) {
      return false;
    }
  }

  static double? calculateDistance(
      double? lat1, double? lon1, double? lat2, double? lon2) {
    if (isNull(lat1) || isNull(lon1) || isNull(lat2) || isNull(lon2)) {
      return null;
    }
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c(((lat2 ?? 0) - (lat1 ?? 0)) * p) / 2 +
        c((lat1 ?? 0) * p) *
            c((lat2 ?? 0) * p) *
            (1 - c(((lon2 ?? 0) - (lon1 ?? 0)) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  static void handleException(SnackBarBloc? snackBarBloc, e,
      {required String methodName,
      String? exceptionName,
      bool showSnackbar = true,
      bool logBug = true,
      String? text}) async {
    LOG.e('GstoreException: ${e.toString()} | $methodName | $exceptionName');
    // if (e is TokenExpiredException) {
    //   injector<SnackBarBloc>().add(ShowSnackbarEvent(
    //     content: e.message,
    //     type: SnackBarType.warning,
    //   ));
    //   Routes.instance.navigateAndRemove(RouteName.loginScreen);
    //   return;
    // }
    if ((e is TimeOutException || e is ConnectException) &&
        snackBarBloc != null) {
      snackBarBloc.add(ShowSnackbarEvent(
        content: 'Đường truyền của bạn không ổn định, vui lòng thử lại',
        type: SnackBarType.warning,
      ));
      return;
    }

    final message = (e is AppException) ? e.message : 'Lỗi không xác định';

    if (showSnackbar && snackBarBloc != null) {
      snackBarBloc.add(ShowSnackbarEvent(content: exceptionName ?? message));
    }
  }

  static String getTwoCharOfName(String? name) {
    try {
      if (name == null || name.isEmpty) {
        return '';
      }
      List<String> listChar = name.trim().split(' ');
      if (listChar.length == 1) {
        if (listChar[0].length == 1) {
          return listChar[0].toUpperCase();
        } else {
          return listChar[0].substring(0, 2).toUpperCase();
        }
      }
      return '${listChar[0].substring(0, 1)}${listChar.last.substring(0, 1)}'
          .toUpperCase();
    } catch (_) {
      return name ?? '';
    }
  }

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    try {
      double.parse(s);
      return true;
    } catch (e) {
      return false;
    }
  }
}
