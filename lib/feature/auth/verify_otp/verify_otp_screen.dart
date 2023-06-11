// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:qrcode/common/navigation/route_names.dart';
// import 'package:qrcode/feature/routes.dart';
// import 'package:qrcode/feature/themes/theme_color.dart';
// import 'package:qrcode/feature/themes/theme_text.dart';
// import 'package:qrcode/feature/widgets/custom_button.dart';
// import 'package:qrcode/feature/widgets/custom_scaffold.dart';
// import 'package:qrcode/feature/widgets/custom_textfield.dart';
//
// class VerifyOtpScreen extends StatefulWidget {
//   final String phone;
//
//   const VerifyOtpScreen({Key? key, required this.phone}) : super(key: key);
//
//   @override
//   _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
// }
//
// class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       autoDismissKeyboard: true,
//       customAppBar: CustomAppBar(
//         title: 'Nhập mã OTP',
//         iconLeftTap: () {
//           Routes.instance.pop();
//         },
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Text(
//               'Nhập mã OTP',
//               style: AppTextTheme.mediumBlack,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Mã OTP sẽ được gửi đến email của bạn',
//               style: AppTextTheme.normalBlack,
//             ),
//             const SizedBox(height: 26),
//             PinCodeTextField(
//               length: 6,
//               obscureText: false,
//               animationType: AnimationType.fade,
//               cursorColor: AppColors.primaryColor,
//               animationDuration: Duration(milliseconds: 300),
//               pinTheme: PinTheme(
//                 borderRadius: BorderRadius.circular(4.0),
//                 activeColor: AppColors.grey7,
//                 inactiveFillColor: AppColors.grey7,
//                 activeFillColor: AppColors.grey7,
//                 selectedFillColor: AppColors.grey7,
//                 inactiveColor: AppColors.primaryColor,
//                 selectedColor: AppColors.grey7,
//               ),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {},
//               appContext: context,
//             ),
//             const SizedBox(height: 40),
//             Text(
//               'Gửi lại mã OTP(00:29)',
//               style: AppTextTheme.mediumBlack.copyWith(
//                 color: Color(0xff6F6F6F),
//               ),
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomButton(
//                   onTap: () {
//                     Routes.instance.navigateTo(RouteName.ChangePassScreen);
//                   },
//                   text: 'Xác nhận',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
