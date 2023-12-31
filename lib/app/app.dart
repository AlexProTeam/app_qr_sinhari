library app_layer;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/config_manager.dart';
import 'package:qrcode/app/managers/route_names.dart';
import 'package:qrcode/app/managers/shared_pref_manager.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/app/managers/status_code_manager.dart';
import 'package:qrcode/app/managers/theme_manager.dart';
import 'package:qrcode/app/route/navigation/slide_left_route.dart';
import 'package:qrcode/app/utils/navigation_util.dart';
import 'package:qrcode/data/app_all_api/api/app_api.dart';
import 'package:qrcode/data/app_all_api/models/request/login_request.dart';
import 'package:qrcode/data/app_all_api/models/response/login_response.dart';
import 'package:qrcode/data/app_all_api/repositories/app_repository_impl.dart';
import 'package:qrcode/data/responses/object_response.dart';
import 'package:qrcode/domain/all_app_doumain/entities/user_entitiy.dart';
import 'package:qrcode/domain/entity/banner_model.dart';
import 'package:qrcode/domain/entity/confirm_model.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/domain/entity/details_news_model.dart';
import 'package:qrcode/domain/entity/history_debt_model.dart';
import 'package:qrcode/domain/entity/home_response.dart';
import 'package:qrcode/domain/entity/introduce_model.dart';
import 'package:qrcode/domain/entity/noti_model.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/domain/entity/profile_model.dart';
import 'package:qrcode/domain/entity/welcome_model.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/auth/change_pass/change_pass_screen.dart';
import 'package:qrcode/presentation/auth/forgot_pass/forgot_pass_screen.dart';
import 'package:qrcode/presentation/auth/login/bloc/login_bloc.dart';
import 'package:qrcode/presentation/auth/login/login_screen.dart';
import 'package:qrcode/presentation/auth/register/register_screen.dart';
import 'package:qrcode/presentation/auth/verify/bloc/verify_bloc.dart';
import 'package:qrcode/presentation/auth/welcome/bloc/welcome_bloc.dart';
import 'package:qrcode/presentation/auth/welcome/welcome_point_widget.dart';
import 'package:qrcode/presentation/feature/address/detail_edit_address_screen.dart';
import 'package:qrcode/presentation/feature/bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import 'package:qrcode/presentation/feature/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:qrcode/presentation/feature/bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'package:qrcode/presentation/feature/cart/cart_screen.dart';
import 'package:qrcode/presentation/feature/detail_order/detail_order_screen.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_active.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_contact.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';
import 'package:qrcode/presentation/feature/history_detb/history_detb_screen.dart';
import 'package:qrcode/presentation/feature/history_scan/history_model.dart';
import 'package:qrcode/presentation/feature/history_scan/ui/history_scan_screen.dart';
import 'package:qrcode/presentation/feature/home/home_screen.dart';
import 'package:qrcode/presentation/feature/infomation_customer/information_customer_screen.dart';
import 'package:qrcode/presentation/feature/list_product/list_product_screen.dart';
import 'package:qrcode/presentation/feature/news/details_news/ui/detail_new_screen.dart';
import 'package:qrcode/presentation/feature/news/history_model.dart';
import 'package:qrcode/presentation/feature/news/news_screen/ui/news_screen.dart';
import 'package:qrcode/presentation/feature/notification/ui/notification_screen.dart';
import 'package:qrcode/presentation/feature/pay_debt/bloc/pay_debt_bloc.dart';
import 'package:qrcode/presentation/feature/pay_debt/pay_debt_qr_screen.dart';
import 'package:qrcode/presentation/feature/pay_debt/pay_debt_screen.dart';
import 'package:qrcode/presentation/feature/personal/contact/contact_screen.dart';
import 'package:qrcode/presentation/feature/personal/enum/personal_menu_enum.dart';
import 'package:qrcode/presentation/feature/personal/personal_screen.dart';
import 'package:qrcode/presentation/feature/personal/terms/ui/terms_screen.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:qrcode/presentation/feature/profile/ui/profile_screen.dart';
import 'package:qrcode/presentation/feature/scan/check_bill_screen.dart';
import 'package:qrcode/presentation/feature/scan_product/scan_qr.dart';
import 'package:qrcode/presentation/feature/success/success_screen.dart';
import 'package:qrcode/presentation/feature/webview/webview_detail_screen.dart';
import 'package:qrcode/presentation/widgets/button_custom.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/custom_image_network.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';
import 'package:qrcode/presentation/widgets/widget_loading.dart';

import '../../data/utils/interceptor/token_interceptor.dart';
import '../data/app_all_api/models/request/confirm_job_request.dart';
import '../data/app_all_api/models/request/update_address.dart';
import '../domain/entity/add_to_cart_model.dart';
import '../domain/entity/address_screen.dart';
import '../domain/entity/confirm_cart_response.dart';
import '../domain/entity/detail_order_response.dart';
import '../domain/entity/list_carts_response.dart';
import '../domain/entity/order_model.dart';
import '../domain/entity/payment_debt_model.dart';
import '../firebase/firebase_config.dart';
import '../presentation/feature/address/address_screen.dart';
import '../presentation/feature/cart/bloc/carts_bloc.dart';
import '../presentation/feature/detail_product/bloc/product_detail_bloc.dart';
import '../presentation/feature/infomation_customer/bloc/info_bloc.dart';
import '../presentation/feature/list_product/bloc/list_product_bloc.dart';

part '../app/di/injection.dart';
part '../app/managers/constant_manager.dart';
part '../app/route/routes.dart';
part '../app/utils/session_utils.dart';
part '../data/utils/interceptor/error_interceptor.dart';
part '../domain/all_app_doumain/repositories/app_repository.dart';
part '../domain/all_app_doumain/usecases/app_usecase.dart';
part '../presentation/auth/splash/splash_screen.dart';
part '../presentation/auth/verify/verify_otp_screen.dart';
part '../presentation/auth/welcome/welcome_screen.dart';
part '../presentation/widgets/dialog_manager_custom.dart';
