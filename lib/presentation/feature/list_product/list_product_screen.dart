import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../app/route/navigation/route_names.dart';
import '../../../app/route/screen_utils.dart';
import '../../widgets/category_product_item.dart';
import '../../widgets/custom_scaffold.dart';
import 'bloc/list_product_bloc.dart';

class ArgumentListProductScreen {
  final String? url;
  final String? label;
  final bool isAgency;

  ArgumentListProductScreen({this.url, this.label, this.isAgency = false});
}

class ListProductScreen extends StatefulWidget {
  final ArgumentListProductScreen? argument;

  const ListProductScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  ListProductScreenState createState() => ListProductScreenState();
}

class ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '${widget.argument?.label}',
        isShowBack: true,
        actions: [
          if (widget.argument?.isAgency ?? false)
            InkWell(
              onTap: () => Navigator.pushNamed(
                  Routes.instance.navigatorKey.currentContext!,
                  RouteDefine.cartScreen),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Assets.icons.icCar.image(
                  width: 30,
                  height: 30,
                ),
              ),
            )
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            ListProductBloc(getIt<AppUseCase>(), widget.argument?.url ?? '')
              ..add(const InitListProductEvent()),
        child: BlocBuilder<ListProductBloc, ListProductState>(
          builder: (BuildContext context, state) {
            final products = state.products ?? [];
            if (state.status == BlocStatusEnum.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (products.isEmpty) {
              return const Center(
                child: Text("Không có sản phẩm nào!"),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0)
                      .copyWith(bottom: getPadding(context)),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                return CategoryItemProduct(
                  itemWidth: (GScreenUtil.screenWidthDp - 48) / 2,
                  productModel: products[index],
                  isAgency: widget.argument?.isAgency ?? false,
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }

  double getPadding(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (height < 800) {
      return 100;
    }
    return 20;
  }
}
