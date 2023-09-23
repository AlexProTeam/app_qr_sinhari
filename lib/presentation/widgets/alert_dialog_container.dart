import 'package:flutter/material.dart';

import '../../app/managers/color_manager.dart';
import '../../app/managers/style_manager.dart';

class AlertDialogContainer extends StatelessWidget {
  final Function? confirm;
  final Function? cancel;
  final String? label;
  final String message;
  final bool? showCancel;
  final String? textCancel;
  final String? textOk;

  const AlertDialogContainer(
      {Key? key,
      this.confirm,
      this.cancel,
      this.label,
      required this.message,
      this.showCancel = false,
      this.textCancel,
      this.textOk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              label ?? 'Notification',
              style: TextStyleManager.mediumBlack,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child: Text(
              message,
              style: TextStyleManager.normalBlack.copyWith(fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
          const Divider(
            height: 1,
            color: AppColors.grey6,
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: <Widget>[
                showCancel ?? false
                    ? Expanded(
                        child: InkWell(
                          onTap: () {
                            if (cancel != null) {
                              cancel!();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                            child: Text(
                              textCancel ?? 'Hủy',
                              style: TextStyleManager.normalBlue.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                const VerticalDivider(
                  width: 1,
                  color: AppColors.grey6,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      confirm!();
                    },
                    child: Center(
                      child: Text(
                        textOk ?? 'OK',
                        textAlign: TextAlign.center,
                        style: TextStyleManager.normalBlue.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
